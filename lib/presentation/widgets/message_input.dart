import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

/// Widget for message input field with voice button
class MessageInput extends StatefulWidget {
  final Function(String) onSendMessage;
  final VoidCallback onMicPressed;
  final bool isListening;
  final String? listeningText;

  const MessageInput({
    Key? key,
    required this.onSendMessage,
    required this.onMicPressed,
    this.isListening = false,
    this.listeningText,
  }) : super(key: key);

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(MessageInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update text field with speech recognition result
    if (widget.listeningText != null && widget.listeningText!.isNotEmpty) {
      _controller.text = widget.listeningText!;
    }
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.trim().isNotEmpty;
    });
  }

  void _handleSend() {
    if (_hasText) {
      widget.onSendMessage(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Mic button
          Container(
            decoration: BoxDecoration(
              color: widget.isListening ? Colors.white : AppTheme.userMessageColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                widget.isListening ? Icons.mic : Icons.mic_none,
                color: widget.isListening
                    ? Colors.black
                    : Colors.white,
              ),
              onPressed: widget.onMicPressed,
              tooltip: 'Voice input',
            ),
          ),

          const SizedBox(width: 12),

          // Text input field
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                hintText: widget.isListening
                    ? 'Listening...'
                    : 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.inputBorderRadius),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppTheme.userMessageColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => _handleSend(),
            ),
          ),

          const SizedBox(width: 12),

          // Send button
          Container(
            decoration: BoxDecoration(
              color: _hasText ? Colors.white : AppTheme.userMessageColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: _hasText ? Colors.black : Colors.white),
              onPressed: _hasText ? _handleSend : null,
              tooltip: 'Send message',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }
}

