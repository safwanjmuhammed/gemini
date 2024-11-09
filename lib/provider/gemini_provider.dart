import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/presentation/gemini_state.dart';
import 'package:gemini/services/gemini_service.dart';

final provider = StateNotifierProvider<GeminiNotifier, GeminiState>(
    (ref) => GeminiNotifier(GeminiState(chatData: [])));

class GeminiNotifier extends StateNotifier<GeminiState> {
  GeminiNotifier(super._state);

  Future<void> fetchGeminiResponse(
      {required BuildContext context, required String chatText}) async {
    final service = GeminiService();
    try {
      state = state.copyWith(isLoading: true);
      final responseText =
          await service.geminiService(context: context, chatText: chatText);

      final newChatItem = {'chat': chatText, 'response': responseText};
      state = state.copyWith(
          chatData: [newChatItem, ...state.chatData].reversed.toList());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
