import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';

class GeminiService {
  GoogleGemini gemini =
      GoogleGemini(apiKey: 'AIzaSyC25d5WTkA-kSMK7cYB_NTk2SrRmHzI4fA');

  Future<String> getGemini(String chatText, BuildContext context) async {
    try {
      final geminiResponse = await gemini.generateFromText(chatText);
      print(geminiResponse.response.promptFeedback);

      print(geminiResponse.text);
      return geminiResponse.text;
    } on DioException catch (e) {
      print(e.message);
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Failed to fetch gemini response..')));
    }
    throw Exception('failed');
  }
}
