

import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class ChatInputWidget extends StatefulWidget {
  final Function(String message) onSend;

  ChatInputWidget({required this.onSend});

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor:
                  Colors.white, // 👈 this sets the cursor color to white
              style: const TextStyle(color: Colors.white), // 👈 text color

              controller: _textController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.grey,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              // onSubmitted:onSend,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                final message = _textController.text.trim();
                if (message.isNotEmpty) {
                  widget.onSend(message);
                  _textController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
