import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ai_chat_llm/providers/ai_provider.dart';
import 'package:the_ai_chat_llm/widgets/chat_bubble.dart';


class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final aiProvider = Provider.of<AIProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Assistant", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: aiProvider.messages.isEmpty 
              ? const Center(child: Opacity(opacity: 0.5, child: Text("No messages yet. Ask me anything!")))
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: aiProvider.messages.length,
                  itemBuilder: (ctx, i) => ChatBubble(message: aiProvider.messages.reversed.toList()[i]),
                ),
          ),
          if (aiProvider.isChatLoading) 
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(backgroundColor: Colors.transparent, color: Colors.blueAccent),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF2C2C2E),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        aiProvider.sendMessage(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}