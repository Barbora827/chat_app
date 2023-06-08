import 'package:chat_app/colors.dart';
import 'package:chat_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BBTextFormField extends StatelessWidget {
  const BBTextFormField(
      {super.key,
      required this.onSaved,
      required this.label,
      required this.textInputType});

  final void Function(String?) onSaved;
  final String label;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    String? validateInput(String? value) {
      if (label == 'Email address') {
        if (value == null || value.trim().isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        }
      }
      if (label == 'Password') {
        if (value == null || value.trim().length <= 6) {
          return 'Password must be at least 6 characters long.';
        }
      }
      if (label == 'Username') {
        if (value == null || value.trim().isEmpty || value.trim().length < 4) {
          return 'A username must be at least 4 characters long';
        }
      }
      return null;
    }

    return TextFormField(
      decoration: InputDecoration(
        label: BBTextWidget(
          text: label,
          color: bbTertiary,
          weight: FontWeight.w600,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: bbTertiary, width: 1.5),
        ),
      ),
      autocorrect: false,
      enableSuggestions: label != 'Username',
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.none,
      validator: validateInput,
      onSaved: onSaved,
      obscureText: label == 'Password',
    );
  }
}
