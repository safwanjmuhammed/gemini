import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.sizeOf(context);
    final verticalPadding = SizedBox(height: mSize.height / 35);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildText(context: context, text: 'Create Account'),
                    buildText(
                        context: context,
                        text: 'Create an account so you can explore gemini'),
                    SizedBox(height: mSize.height / 20),
                    SvgPicture.asset(
                      'assets/images/ai-platform-unified-svgrepo-com.svg',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: mSize.height / 20),
                    AppTextField(
                      textCondroller: _nameController,
                      hintText: 'Email',
                    ),
                    verticalPadding,
                    AppTextField(
                      textCondroller: _nameController,
                      hintText: 'Password',
                    ),
                    verticalPadding,
                    AppTextField(
                      textCondroller: _nameController,
                      hintText: 'Confirm Password',
                    ),
                    verticalPadding,
                    SizedBox(
                      width: mSize.width * 0.6,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Sign up',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Widget buildText({required BuildContext context, required String text}) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyMedium,
  );
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.textCondroller,
    this.hintText,
  });
  final String? hintText;
  final TextEditingController textCondroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).cardColor,
      ),
      child: TextField(
        controller: textCondroller,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
            hintText: hintText,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            contentPadding: const EdgeInsets.only(left: 10)),
        onTap: () {},
      ),
    );
  }
}
