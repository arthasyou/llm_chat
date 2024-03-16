import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:llm_chat/services/assets_manager.dart';

import 'package:llm_chat/widgets/chat_widget.dart';

import '../../services/services.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  // bool _isTyping = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.logo),
        ),
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          ),
        ],
      ),
      body: ChatViewWidget(),
    );
  }
}
