import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // Assuming you have this file for colors

class ChatMessageWidget extends StatelessWidget {
  final String message;
  final String sender;
  final int timestamp;
  final bool isMe;
  final List<String> seenBy; // Optional: for seen receipts

  const ChatMessageWidget({
    super.key, 
    required this.message,
    this.sender = "User",
    this.timestamp = 0,
    this.isMe = false,
    this.seenBy = const [],
  });

  String _formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    return "${hour}:${date.minute.toString().padLeft(2, '0')} $amPm";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bubbleWidth = screenWidth * 0.7;
    final padding = screenWidth * 0.03;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Chat Bubble
          Container(
            constraints: BoxConstraints(maxWidth: bubbleWidth),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
                border: Border.all(
    color: isMe 
        ? AppColors.primaryColor // Outline color for your messages
        : Colors.transparent, // Outline color for others' messages
    width: 1.0,
  ),
              color: isMe
                  ? Color.fromARGB(255, 33, 65, 36) // Your gradient colors
                  : AppColors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMe ? 15 : 5),
                topRight: Radius.circular(isMe ? 5 : 15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                Text(
                  message,
                  style: TextStyle(
                    color:  Colors.white,
                  ),
                ),
                SizedBox(height: padding * 0.8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatTimestamp(timestamp),
                      style: TextStyle(
                        fontSize: screenWidth * 0.028,
                        color:Colors.white70,
                      ),
                    ),
                    if (isMe && seenBy.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.done_all, 
                              size: screenWidth * 0.035,
                              color: Colors.white70),
                          SizedBox(width: 4),
                          Text(
                            'Seen',
                            style: TextStyle(
                              fontSize: screenWidth * 0.028,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}