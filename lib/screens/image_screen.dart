import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ai_provider.dart';

class ImageScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final aiProvider = Provider.of<AIProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("AI Image Generator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: const InputDecoration(hintText: "Describe the image...")),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => aiProvider.generateAiImage(_controller.text),
              child: const Text("Generate Image"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: aiProvider.isImageLoading 
                ? const Center(child: CircularProgressIndicator())
                : aiProvider.generatedImageUrl.isEmpty 
                  ? const Center(child: Text("Enter a prompt to begin"))
                  : Image.network(aiProvider.generatedImageUrl),
            )
          ],
        ),
      ),
    );
  }
}