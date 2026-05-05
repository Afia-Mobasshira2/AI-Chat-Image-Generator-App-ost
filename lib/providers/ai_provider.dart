import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:the_ai_chat_llm/models/chat_model.dart';
import 'package:the_ai_chat_llm/services/openai_service.dart';


class AIProvider with ChangeNotifier {
  final AIService _aiService = AIService();
  
  // Chat State
  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;
  bool _isChatLoading = false;
  bool get isChatLoading => _isChatLoading;

  // Image State
  String _generatedImageUrl = "";
  String get generatedImageUrl => _generatedImageUrl;
  bool _isImageLoading = false;
  bool get isImageLoading => _isImageLoading;

  Future<void> sendMessage(String text) async {
    _messages.add(ChatMessage(text: text, isUser: true, timestamp: DateTime.now()));
    _isChatLoading = true;
    notifyListeners();

    try {
      final history = _messages.map((m) => OpenAIChatCompletionChoiceMessageModel(
        role: m.isUser ? OpenAIChatMessageRole.user : OpenAIChatMessageRole.assistant,
        content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(m.text)],
      )).toList();

      final response = await _aiService.getChatResponse(history);
      _messages.add(ChatMessage(text: response, isUser: false, timestamp: DateTime.now()));
    } catch (e) {
      _messages.add(ChatMessage(text: "Error: $e", isUser: false, timestamp: DateTime.now()));
    } finally {
      _isChatLoading = false;
      notifyListeners();
    }
  }

  Future<void> generateAiImage(String prompt) async {
    _isImageLoading = true;
    _generatedImageUrl = "";
    notifyListeners();

    try {
      _generatedImageUrl = await _aiService.generateImage(prompt);
    } catch (e) {
      _generatedImageUrl = "error";
    } finally {
      _isImageLoading = false;
      notifyListeners();
    }
  }
}