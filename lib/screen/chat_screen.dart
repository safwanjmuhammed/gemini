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
  String geminiText = '';
  bool isTextEmpty = true;
  bool isGenerating = false;

  getGeminiResponse() async {
    final service = GeminiService();
    final responseText = await service.getGemini(chatController.text, context);
    setState(() {
      geminiText = responseText;
    });
  }

  chatControllerListen() {
    chatController.addListener(() {
      setState(() {
        isTextEmpty = chatController.text.characters.isEmpty;
        print(isTextEmpty);
      });
    });
  }

  addingchatToList(String chat) {
    List<String> chats = [];
    setState(() {
      chats.addAll(chats);
      print(chats.length);
    });
  }

  @override
  void dispose() {
    super.dispose();
    chatController.text;
  }

  // @override
  // void initState() {
  //   chatControllerListen();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        // leading: Image.asset(''),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isGenerating
                ? Expanded(
                    child: ListView(children: [
                    chat(
                      context,
                      geminiText,
                      chatText,
                      platformBrightness,
                    )
                  ]))
                : const SizedBox(),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          onPressed: () {
                            getGeminiResponse();
                            setState(() {
                              isGenerating = true;
                              chatText = chatController.text;
                            });
                            addingchatToList(chatText);
                            chatController.clear();
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          icon: isTextEmpty
                              ? const SizedBox()
                              : const Icon(Icons.arrow_circle_right_outlined))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
