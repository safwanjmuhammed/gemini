import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gemini/components/chat_widget.dart';
import 'package:gemini/services/gemini_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = TextEditingController();

  String chatText = '';
  String? geminiText;
  bool isTextEmpty = true;
  bool isGenerating = false;

  List<Map<String, dynamic>> chatList = [];
  final _scrollController = ScrollController();

  Future<String?> getGeminiResponse() async {
    final service = GeminiService();
    try {
      final responseText =
          await service.geminiService(context: context, chatText: chatText);
      return responseText;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
    return null;
  }

  void chatControllerListen() {
    chatController.addListener(() {
      setState(() {
        isTextEmpty = chatController.text.characters.isEmpty;
      });
    });
  }

  void addChatToList(
    String chatText,
    String geminiText,
  ) {
    chatList.addAll([
      {'chat': chatText, 'response': geminiText},
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final platformBrightness = MediaQuery.platformBrightnessOf(context);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isGenerating
              ? Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: chatList.length,
                      itemBuilder: ((context, index) {
                        return chat(context, chatList[index]['response'],
                            chatList[index]['chat'], platformBrightness);
                      })),
                )
              : const SizedBox(),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).cardColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            hintText: 'Message',
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            contentPadding: const EdgeInsets.only(left: 10)),
                        onTap: () {
                          chatControllerListen();
                        },
                      ),
                    ),
                    IconButton(
                        style: Theme.of(context).iconButtonTheme.style,
                        iconSize: 30,
                        onPressed: () async {
                          setState(() {
                            isGenerating = true;
                          });
                          chatText = chatController.text;
                          final geminiText = await getGeminiResponse();
                          if (geminiText == null || geminiText.isEmpty) return;
                          setState(() {
                            addChatToList(chatText, geminiText);
                            _scrollToItem(controller: _scrollController);
                          });
                          FocusManager.instance.primaryFocus!.unfocus();
                          chatController.clear();
                        },
                        icon: isTextEmpty
                            ? const SizedBox()
                            : const Icon(Icons.arrow_circle_right_outlined))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

void _scrollToItem({required ScrollController controller}) {
  final scrollPosition = controller.position.maxScrollExtent;
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    controller.jumpTo(scrollPosition);
  });
}
