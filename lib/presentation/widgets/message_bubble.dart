import 'package:flutter/material.dart';
import '../../data/models/message.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

/// Widget for displaying a single chat message
class MessageBubble extends StatelessWidget {
  final Message message;
  final VoidCallback? onSpeakPressed;

  const MessageBubble({
    Key? key,
    required this.message,
    this.onSpeakPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: AppConstants.messageSpacing / 2,
          horizontal: 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser
              ? AppTheme.userMessageColor
              : AppTheme.aiMessageColor,
          borderRadius: BorderRadius.circular(AppConstants.messageBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Message text
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser
                    ? AppTheme.userTextColor
                    : AppTheme.aiTextColor,
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 8),

            // Message footer with timestamp and actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Timestamp
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    color: message.isUser
                        ? AppTheme.userTextColor.withOpacity(0.7)
                        : AppTheme.aiTextColor.withOpacity(0.5),
                    fontSize: 11,
                  ),
                ),

                // Speaker icon for AI messages
                if (!message.isUser && onSpeakPressed != null) ...[
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: onSpeakPressed,
                    child: Icon(
                      Icons.volume_up,
                      size: 18,
                      color: AppTheme.aiTextColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

