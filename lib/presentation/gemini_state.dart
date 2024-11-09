class GeminiState {
  final bool? isGenerating;
  List<Map<String, dynamic>> chatData = [];
  final bool? isLoading;

  GeminiState({this.isGenerating, required this.chatData, this.isLoading});

  GeminiState copyWith(
      {bool? isGenerating,
      List<Map<String, dynamic>>? chatData,
      bool? isLoading}) {
    return GeminiState(
        isGenerating: isGenerating ?? this.isGenerating,
        chatData: chatData ?? this.chatData,
        isLoading: isLoading ?? this.isLoading);
  }
}
