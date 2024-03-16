import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:llm_chat/models/model.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> _chats = [ChatModel(msg: "123", chatIndex: 1)];
  List<ChatModel> get chats => _chats;

  void setChat(List<ChatModel> chats) {
    _chats = chats;
    notifyListeners();
  }

  void clearChat() {
    _chats = [];
    notifyListeners();
  }

  Future<void> addMessage({required String msg, required int index}) async {
    print("going here");
    _chats.add(ChatModel(msg: msg, chatIndex: index));
    notifyListeners();
  }
}

final chatProvider = ChangeNotifierProvider<ChatProvider>((ref) {
  return ChatProvider();
});
