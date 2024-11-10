import 'package:flutter/material.dart';

Widget chat(BuildContext context, String geminiText, String chatControllerText,
    Brightness platformBrightness) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0XFF50577A),
              child: Text(
                'SA',
                style: platformBrightness == Brightness.light
                    ? const TextStyle(color: Colors.white)
                    : Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(width: 10),
            Text('YOU', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            chatControllerText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        //// GEMINI CHAT
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0XFF50577A),
                child: Text(
                  'G',
                  style: platformBrightness == Brightness.light
                      ? const TextStyle(color: Colors.white)
                      : Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 10),
              Text('GEMINI', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: geminiText.isEmpty
              ? Text(
                  'Generating.....',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : Text(
                  geminiText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
        ),
      ],
    ),
  );
}
