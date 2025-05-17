import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/chat_screen/load_message_animation.dart';
import 'package:sky_diving/components/chat_input_widget.dart';
import 'package:sky_diving/components/message_widget.dart';
import 'package:sky_diving/constants/app_images.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
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
                        timestamp: messages[messageIndex].time,
                        message: messages[messageIndex].message,
                        sender: "support",
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
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          BackButton(color: Colors.white),
          // const SizedBox(width: 2),
          Image.asset(
            AppImages.groupProfile,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer support",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
