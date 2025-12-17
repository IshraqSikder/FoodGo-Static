import 'package:flutter/material.dart';
import 'package:foodgo_static/models/message.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var messages = <Message>[].obs;

  final TextEditingController textInputController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadInitialMessages();
  }

  void loadInitialMessages() {
    messages.addAll([
      Message(text: "Hi, how can I help you?", isMe: false),
      Message(
        text:
            "Hello, I ordered two fried chicken burgers. can I know how much time it will get to arrive?",
        isMe: true,
      ),
      Message(text: "Ok, please let me check!", isMe: false),
      Message(text: "Sure...", isMe: true),
      Message(
        text: "It'll get 25 minutes to arrive to your address",
        isMe: false,
      ),
      // Adding a time separator object
      Message(text: "26 minutes ago", isMe: false, isTimeSeparator: true),
      Message(text: "Ok, thanks you for your support", isMe: true),
    ]);
  }

  void sendMessage() {
    if (textInputController.text.trim().isNotEmpty) {
      messages.add(Message(text: textInputController.text.trim(), isMe: true));
      textInputController.clear();

      // Auto-scroll logic would go here in a real app
    }
  }

  @override
  void onClose() {
    textInputController.dispose();
    super.onClose();
  }
}
