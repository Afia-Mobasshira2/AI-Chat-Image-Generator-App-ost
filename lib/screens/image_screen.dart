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
              child: Center(
                child:
                    aiProvider.isImageLoading
                        ? const CircularProgressIndicator()
                        : aiProvider.generatedImageUrl.isEmpty
                        ? const Icon(
                          Icons.image_search,
                          size: 100,
                          color: Colors.white24,
                        )
                        : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueAccent.withOpacity(0.3),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              aiProvider.generatedImageUrl,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const CircularProgressIndicator();
                              },
                            ),
                          ),
                        ),
              ),
            )
          ],
        ),
      ),
    );
  }
}