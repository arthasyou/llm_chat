import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:llm_chat/constants/constants.dart';
import 'package:llm_chat/services/assets_manager.dart';
import 'package:llm_chat/widgets/text_widget.dart';

import '../provider/chat_provider.dart';
import '../services/api_service.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scafoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  height: 30,
                  width: 30,
                ),
                Expanded(child: TextWidget(label: msg)),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChatViewWidget extends ConsumerWidget {
  ChatViewWidget({super.key});
  bool _isTyping = true;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(chatProvider);
    return SafeArea(
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: provider.chats.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: provider.chats[index].msg,
                    chatIndex: provider.chats[index].chatIndex,
                  );
                }),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: textEditingController,
                        onSubmitted: (value) {
                          // TODO send message
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: "How Can I help you",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      // onPressed: () {},
                      onPressed: () async {
                        await sendMessage(
                            provider: provider,
                            msg: textEditingController.text);
                        // try {
                        //   await ApiService.sendMessage();
                        // } catch (error) {
                        //   // print("error: $error");
                        // }
                      },
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> sendMessage(
      {required ChatProvider provider, required String msg}) async {
    provider.addMessage(msg: textEditingController.text, index: 0);
    final text = await ApiService.sendMessage();
    provider.addMessage(msg: text, index: 1);
  }
}
