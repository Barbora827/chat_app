import 'package:chat_app/colors.dart';

import 'package:chat_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BBElevatedButton extends StatelessWidget {
  const BBElevatedButton(
      {super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bbTertiary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
        ),
      ),
      onPressed: onPressed,
      child: BBTextWidget(
        text: text,
        weight: FontWeight.bold,
      ),
    );
  }
}
