import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/core/theme.dart';
import 'package:gemini/presentation/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gemini',
        themeMode: ThemeMode.system,
        theme: CustomTheme.darkTheme,
        darkTheme: CustomTheme.darkTheme,
        home: const ChatScreen(),
      ),
    );
  }
}
