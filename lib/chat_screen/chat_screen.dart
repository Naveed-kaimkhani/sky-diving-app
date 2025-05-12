// import 'package:flutter/material.dart';
// import 'package:sky_diving/components/message_widget.dart';
// import 'package:sky_diving/constants/app_colors.dart';

// // Message model class
// class ChatMessage {
//   final String text;
//   final String sender;
//   final bool isMe;
//   final DateTime timestamp;

//   ChatMessage({
//     required this.text,
//     required this.sender,
//     required this.isMe,
//     required this.timestamp,
//   });
// }

// class GroupChatScreen extends StatefulWidget {
//   final String groupName;
//   final int memberCount;
//   final String? profileImage;
//   final List<ChatMessage> initialMessages;

//   const GroupChatScreen({
//     super.key,
//     required this.groupName,
//     this.profileImage,
//     required this.memberCount,
//     required this.initialMessages,
//   });

//   @override
//   _GroupChatScreenState createState() => _GroupChatScreenState();
// }

// class _GroupChatScreenState extends State<GroupChatScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController _messageController = TextEditingController();
//   late List<ChatMessage> _messages;

//   @override
//   void initState() {
//     super.initState();
//     _messages = widget.initialMessages;
//     WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
//   }

//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     }
//   }

//   void _onSendMessage() {
//     if (_messageController.text.trim().isEmpty) return;

//     final newMessage = ChatMessage(
//       text: _messageController.text,
//       sender: "You", // In real app, use actual user name
//       isMe: true,
//       timestamp: DateTime.now(),
//     );

//     setState(() {
//       _messages.add(newMessage);
//       _messageController.clear();
//     });

//     _scrollToBottom();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Column(
//           children: [
//             _buildGroupAppBar(),
//             Expanded(
//               child: ListView.builder(
//                 controller: _scrollController,
//                 padding: const EdgeInsets.all(16),
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                   return _buildMessageBubble(_messages[index]);
//                 },
//               ),
//             ),
//             _buildMessageInput(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGroupAppBar() {
//     return Container(
//       // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Row(
//             children: [
//         BackButton(
//           color: Colors.white,
//         ),
//           Image.asset(widget.profileImage!),
//             ],
//           ),

//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.groupName,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 "${widget.memberCount} hr ago",
//                 style: const TextStyle(
//                   color: AppColors.primaryColor,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(ChatMessage message) {
//     return
//    ChatMessageWidget(message: message.text, isMe: message.isMe,);
//   }

//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText: "Type a message...",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(24),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: AppColors.grey,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//               ),
//               onSubmitted: (_) => _onSendMessage(),
//             ),
//           ),
//           const SizedBox(width: 8),
//           CircleAvatar(
//             backgroundColor: AppColors.primaryColor,
//             child: IconButton(
//               icon: const Icon(Icons.send, color: Colors.white),
//               onPressed: _onSendMessage,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/chat_screen/load_message_animation.dart';
import 'package:sky_diving/components/chat_input_widget.dart';
import 'package:sky_diving/components/message_widget.dart';
import 'package:sky_diving/models/message_model.dart';
import 'package:sky_diving/services/messaging_api.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class GroupChatScreen extends StatefulWidget {
  GroupChatScreen({
    super.key,
  });

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  late GroupChatViewModel viewModel;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingOlderMessages = false;
  StreamSubscription<List<MessageModel>>? _messagesSubscription;
  bool _shouldScrollToBottom = true;

  @override
  void initState() {
    super.initState();
    final UserController userController = Get.find<UserController>();

    viewModel = Get.put(GroupChatViewModel(
      token: userController.token.value,
      userId: userController.user.value!.id.toString(),
    ));

    _scrollController.addListener(_onScroll);

    // Subscribe to messages stream
    _messagesSubscription = viewModel.messagesStream.listen((messages) {
      if (_shouldScrollToBottom && messages.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            // _scrollController
            //     .jumpTo(_scrollController.position.maxScrollExtent);
            _scrollController.jumpTo(0); // or animateTo(0)
          }
        });
      }
    });
  }

  void _onScroll() async {
    if (_scrollController.position.pixels ==
            _scrollController.position.minScrollExtent &&
        !_isLoadingOlderMessages) {
      setState(() {
        _isLoadingOlderMessages = true;
        _shouldScrollToBottom = false;
      });

      final double offsetBefore = _scrollController.position.maxScrollExtent;

      // await viewModel.loadMoreMessages();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          final double offsetAfter = _scrollController.position.maxScrollExtent;
          final double scrollOffsetDelta = offsetAfter - offsetBefore;

          _scrollController
              .jumpTo(_scrollController.position.pixels + scrollOffsetDelta);
        }
      });

      setState(() {
        _isLoadingOlderMessages = false;
      });
    }
  }

  void _scrollToBottom() {
    setState(() {
      _shouldScrollToBottom = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0, // Reversed list -> scroll to 0
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    // controller.hideReactionSheet();
    _messagesSubscription?.cancel();
    _scrollController.dispose();
    Get.delete<GroupChatViewModel>();

    // controller.hid
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.guid);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: viewModel.messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadMessageAnimation();
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No messages found"));
                }

                final messages = snapshot.data!;

                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  padding: EdgeInsets.all(16),
                  itemCount:
                      (_isLoadingOlderMessages ? 1 : 0) + messages.length,
                  itemBuilder: (context, index) {
                    if (_isLoadingOlderMessages && index == 0) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final messageIndex =
                        index - (_isLoadingOlderMessages ? 1 : 0);

                    // ✅ Safety check
                    if (messageIndex < 0 || messageIndex >= messages.length) {
                      return const SizedBox.shrink();
                    }

                    // return ChatMessageWidget(message: messages[messageIndex]);
                    return ChatMessageWidget(
                      message: messages[messageIndex].message,
                      isMe: messages[messageIndex].isMe,
                    );
                  },
                );
              },
            ),
          ),
          ChatInputWidget(
            onSend: (message) {
              viewModel.sendMessage(message).then((_) {
                _scrollToBottom();
                setState(() {
                  viewModel.replyingTo.value = null;
                });
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    return ChatMessageWidget(
      message: message.message,
      isMe: message.isMe,
    );
  }
}
