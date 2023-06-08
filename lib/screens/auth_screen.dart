import 'dart:io';

import 'package:chat_app/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/elevated_button_widget.dart';
import '../widgets/text_form_field_widget.dart';
import '../widgets/text_widget.dart';
import '../widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  File? _enteredImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || !_isLogin && _enteredImage == null) {
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_enteredImage!);
        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl,
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: BBTextWidget(text: e.message ?? 'Authentication failed'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            bbPrimary,
            bbSecondary,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.chat_rounded,
                  size: 200,
                  color: Colors.white,
                ),
                const BBTextWidget(
                  text: 'CandyChat',
                  size: 45,
                  weight: FontWeight.w800,
                ),
                const Gap(15),
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: bbWhite,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            !_isLogin
                                ? UserImagePicker(
                                    onPickedImage: (pickedImage) {
                                      _enteredImage = pickedImage;
                                    },
                                  )
                                : const SizedBox(),
                            BBTextFormField(
                              label: 'Email address',
                              textInputType: TextInputType.emailAddress,
                              onSaved: (newValue) {
                                _enteredEmail = newValue!;
                              },
                            ),
                            if (!_isLogin)
                              BBTextFormField(
                                  onSaved: (newValue) {
                                    _enteredUsername = newValue!;
                                  },
                                  label: 'Username',
                                  textInputType: TextInputType.text),
                            BBTextFormField(
                              label: 'Password',
                              textInputType: TextInputType.text,
                              onSaved: (newValue) {
                                _enteredPassword = newValue!;
                              },
                            ),
                            const Gap(25),
                            !_isAuthenticating
                                ? BBElevatedButton(
                                    onPressed: _submit,
                                    text: _isLogin ? 'Log in' : 'Sign up')
                                : const CircularProgressIndicator(),
                            const Gap(10),
                            !_isAuthenticating
                                ? Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      _isLogin
                                          ? Container()
                                          : const BBTextWidget(
                                              text: 'Already have an account?',
                                              color: bbBrown),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isLogin = !_isLogin;
                                          });
                                        },
                                        child: BBTextWidget(
                                          text: _isLogin
                                              ? 'Create an account'
                                              : 'Log in',
                                          weight: FontWeight.w800,
                                          color: bbTertiary,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
