import 'package:flutter/material.dart';
import 'package:gemini/core/config/keys.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  Future<String?> geminiService(
      {required BuildContext context, required String chatText}) async {
    try {
      final model = GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: Config.apiKey); // your api key here

      final prompt = chatText;
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
    return null;
  }
}
