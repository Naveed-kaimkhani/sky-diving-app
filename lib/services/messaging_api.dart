import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/models/message_model.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';

class GroupChatViewModel extends GetxController {
  // final String groupId;
  final String token;
  final String userId;

  GroupChatViewModel({
    // required this.groupId,
    required this.token,
    required this.userId,
  });
  final Rx<MessageModel?> replyingTo = Rx<MessageModel?>(null);

  final StreamController<List<MessageModel>> _messageController =
      StreamController<List<MessageModel>>.broadcast();
  Stream<List<MessageModel>> get messagesStream => _messageController.stream;

  final ApiClient apiClient = Get.find<ApiClient>();
  Timer? _timer;
  bool _isLoading = false;
  bool hasMoreMessages = true;
  List<MessageModel> _messages = [];

  @override
  void onInit() {
    super.onInit();
    _fetchInitialMessages(); // Fetch initial 20 messages
    _timer = Timer.periodic(
        Duration(seconds: 3), (timer) => _fetchInitialMessages());
  }

  @override
  void onClose() {
    _timer?.cancel();
    _messageController.close();
    super.onClose();
  }

  Future<void> _fetchInitialMessages() async {
    log("in initial message");
    log(userId.toString());
    try {
      final response = await ApiClient.getMessages(
        url: "https://274934fb7af66daf.api-us.cometchat.io/v3/users/1/messages",
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "apikey": "c80baac1dcb708fd88445e6afed1e51cdd16ca4b",
          "onBehalfOf": userId,
        },
      );
      // log("resposne body");
      // log(response.body);
      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        final List<dynamic> rawMessages = responseData['data'] ?? [];

        // if (rawMessages.isEmpty) {
        //   debugPrint("No messages found");
        //   return;
        // }

        final List<Map<String, dynamic>> cleanedRawMessages = rawMessages
            .map((msg) {
              final sender = msg['data']?['entities']?['sender']?['entity'];
              if (sender == null ||
                  sender['name'] == null ||
                  sender['uid'] == null) return null;

              return {
                'id': msg['id'] ?? '',
                'name': sender['name'],
                'avatar': sender['avatar'] ??
                    'https://your-default-avatar-url.com/default.png',
                'uid': sender['uid'],
                'message': msg['data']?['text'] ?? '',
                'reactions': msg['data']?['reactions'] ?? [],
                'sentAt': msg['sentAt'],
                'parentId': msg['parentId'],
                'userId': userId,
              };
            })
            .whereType<Map<String, dynamic>>()
            .toList();

        final List<MessageModel> formattedMessages =
            parseMessages(cleanedRawMessages);
        formattedMessages.sort((a, b) => (b.time).compareTo(a.time));

        _messages = formattedMessages;
        _messageController.add(_messages);

        final meta = {
          'previous': responseData['meta']?['previous'],
          'current': {
            'limit': 200,
            'count': formattedMessages.length,
          },
          'next': responseData['meta']?['next'],
        };
        debugPrint("Pagination Meta: $meta");
      }
    } catch (e) {
      debugPrint("Error fetching 1-on-1 messages: $e");
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMoreMessages() async {
    // await _loadMoreMessages();
  }

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    try {
      final response = await apiClient.sendMessageAPI(
        url: ApiEndpoints.sendMessage,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "apikey": "c80baac1dcb708fd88445e6afed1e51cdd16ca4b",
          "onBehalfOf": userId,
        },
        body: jsonEncode({
          "category": "message",
          "type": "text",
          "data": {
            "text": message,
          },
          "receiver": "1",
          "receiverType": "user",
        }),
      );
      log(response.body);
      if (response.statusCode == 200) {
        _fetchInitialMessages(); // Refresh messages after sending a new one
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send message: $e");
    }
  }
}
