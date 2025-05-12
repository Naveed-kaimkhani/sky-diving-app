import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sky_diving/components/send_button.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.02,
        horizontal: screenWidth * 0.04,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color.fromARGB(255, 214, 211, 211)),
              ),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Type here...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 14),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          SendButton(
            onSend: () {
              final message = _textController.text.trim();
              if (message.isNotEmpty) {
                widget.onSend(message);
                _textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
