import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/components/chat_widget.dart';
import 'package:gemini/presentation/gemini_state.dart';
import 'package:gemini/provider/gemini_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final chatController = TextEditingController();

  String chatText = '';
  String? geminiText;
  bool isTextEmpty = true;
  bool isGenerating = false;

  GeminiState get state => ref.watch(provider);
  GeminiNotifier get notifier => ref.read(provider.notifier);
  final _scrollController = ScrollController();
  void chatControllerListener() {
    chatController.addListener(() {
      setState(() {
        isTextEmpty = chatController.text.characters.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final platformBrightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          state.chatData.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.chatData.length,
                      itemBuilder: ((context, index) {
                        return chat(context, state.chatData[index]['response'],
                            state.chatData[index]['chat'], platformBrightness);
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
                          chatControllerListener();
                        },
                      ),
                    ),
                    IconButton(
                        style: Theme.of(context).iconButtonTheme.style,
                        iconSize: 30,
                        onPressed: () async {
                          try {
                            chatText = chatController.text;
                            await notifier.fetchGeminiResponse(
                                context: context, chatText: chatText);
                            _scrollToItem(controller: _scrollController);
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
                          FocusManager.instance.primaryFocus!.unfocus();
                          chatController.clear();
                        },
                        icon: isTextEmpty
                            ? const SizedBox()
                            : state.isLoading == true
                                ? Transform.scale(
                                    scale: 0.5,
                                    child: const CircularProgressIndicator())
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
  Future.delayed(const Duration(milliseconds: 100), () {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.jumpTo(scrollPosition);
    });
  });
}
