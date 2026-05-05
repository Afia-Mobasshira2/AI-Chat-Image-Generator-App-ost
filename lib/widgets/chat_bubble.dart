import 'package:flutter/material.dart';
import 'package:the_ai_chat_llm/models/chat_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          gradient: message.isUser 
            ? const LinearGradient(colors: [Color(0xFF6A11CB), Color(0xFF2575FC)])
            : const LinearGradient(colors: [Color(0xFF2C2C2E), Color(0xFF3A3A3C)]),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(message.isUser ? 20 : 0),
            bottomRight: Radius.circular(message.isUser ? 0 : 20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))
          ],
        ),
        child: Text(
          message.text,
          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}