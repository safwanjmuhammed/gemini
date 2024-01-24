import 'package:dio/dio.dart';
import 'package:google_gemini/google_gemini.dart';

class GeminiService {
  GoogleGemini gemini =
      GoogleGemini(apiKey: 'AIzaSyC25d5WTkA-kSMK7cYB_NTk2SrRmHzI4fA');

  void getGemini() async {
    try {
      final response = await gemini.generateFromText('what is gemni');
      print(response.text);
      print(response.response);
    } on DioException catch (e) {
      print(e.message);
    }
  }
}
