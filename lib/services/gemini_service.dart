import 'package:dio/dio.dart';
import 'package:google_gemini/google_gemini.dart';

class GeminiService {
  GoogleGemini gemini =
      GoogleGemini(apiKey: 'AIzaSyC25d5WTkA-kSMK7cYB_NTk2SrRmHzI4fA');

  Future<String> getGemini(String chatText) async {
    try {
      final geminiResponse = await gemini.generateFromText(chatText);
      print(geminiResponse.text);
      return geminiResponse.text;
    } on DioException catch (e) {
      print(e.message);
    }
    throw Exception('failed');
  }
}
