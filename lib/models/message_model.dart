import 'dart:developer';

class MessageModel {
  final String sender;
  final String id;
  final String message;
  final bool isMe;
  final int time;
  final List<String> seenBy;
  final List<ReactionModel> reactions;
  // final int time; // 👈 This will hold sentAt from JSON
  MessageModel? parentMessage; // Resolved later after parsing all messages
  final String? parentId;

  final MessageModel? replyTo; // 👈 new field

  MessageModel({
    required this.sender,
    required this.message,
    required this.isMe,
    required this.id,
    required this.time,
    this.replyTo,
    this.parentId,
    this.parentMessage,
    this.seenBy = const [],
    this.reactions = const [],
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    List<ReactionModel> parsedReactions = [];

    // Safely parse reactions only if it's a valid list
    if (json['reactions'] is List) {
      parsedReactions = (json['reactions'] as List)
          .map((e) => ReactionModel.fromJson(e))
          .toList();
    }

    return MessageModel(
      sender: json['name'],
      message: json['message'],
      id: json['id'],
      parentId: json['parentId'],
      replyTo: json['replyto'],
      isMe: json['uid'] == json['userId'],
      time: json['sentAt'],
      seenBy: List<String>.from(json['seenBy'] ?? []),
      reactions: parsedReactions,
    );
  }
}

class ReactionModel {
  final String reaction;
  final int count;

  ReactionModel({
    required this.reaction,
    required this.count,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      reaction: json['reaction'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}

List<MessageModel> parseMessages(List<dynamic> jsonList) {
  final messages = jsonList.map((json) => MessageModel.fromJson(json)).toList();
  return messages;
}
