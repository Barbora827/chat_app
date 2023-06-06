import 'package:chat_app/colors.dart';
import 'package:chat_app/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

final _firebase = FirebaseAuth.instance;

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BBTextWidget(text: 'Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {
              _firebase.signOut();
            },
            icon: const Icon(Icons.logout),
            color: bbWhite,
          ),
        ],
      ),
      body: const Center(
        child: BBTextWidget(
          text: 'You are now logged in',
          color: bbPrimary,
          size: 25,
          weight: FontWeight.w700,
        ),
      ),
    );
  }
}
