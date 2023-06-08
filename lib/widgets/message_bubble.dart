import 'package:chat_app/colors.dart';
import 'package:chat_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MessageBubble extends StatelessWidget {
  // Create a message bubble which is meant to be the first in the sequence.
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  // Create a amessage bubble that continues the sequence.
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  final bool isFirstInSequence;
  final String? userImage;
  final String? username;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 5,
            right: isMe ? 7 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userImage!,
              ),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                        bottom: 5,
                      ),
                      child: BBTextWidget(
                        text: username!,
                        color: bbBrown,
                        weight: FontWeight.w700,
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: isMe
                          ? LinearGradient(colors: [
                              bbPrimaryLighter,
                              bbTertiary.withOpacity(0.8)
                            ])
                          : const LinearGradient(
                              colors: [bbWhite, bbWhite],
                            ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: !isMe ? bbPrimaryDarker : Colors.transparent,
                          width: 1.5),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 18,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: BBTextWidget(
                        text: message,
                        color: isMe ? bbWhite : bbPrimaryDarker,
                        weight: FontWeight.w600,
                        align: isMe ? TextAlign.right : TextAlign.left),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
