import 'package:chat_app/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();

    final currentUser = FirebaseAuth.instance.currentUser!;
    final fetchedData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': currentUser.uid,
      'username': fetchedData.data()!['username'],
      'userImage': fetchedData.data()!['image_url'],
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 1, bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Send a message',
                labelStyle: TextStyle(color: bbPrimaryDarker),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: bbPrimary),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _submitMessage,
            icon: const Icon(
              Icons.send,
              color: bbPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
