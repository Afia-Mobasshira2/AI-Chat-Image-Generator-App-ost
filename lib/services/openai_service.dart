import 'package:dart_openai/dart_openai.dart';

class AIService {
  AIService() {
    OpenAI.apiKey = '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';
  }

  // Chat logic
  Future<String> getChatResponse(List<OpenAIChatCompletionChoiceMessageModel> history) async {
    final completion = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: history,
    );
    return completion.choices.first.message.content?.first.text ?? "No response";
  }

  // Image logic
  Future<String> generateImage(String prompt) async {
    final image = await OpenAI.instance.image.create(
      model: "dall-e-3",
      prompt: prompt,
      n: 1,
      size: OpenAIImageSize.size1024,
    );
    return image.data.first.url ?? "";
  }
}