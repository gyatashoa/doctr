import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  const EmojiButton(
      {Key? key, required this.onTap, required this.text, required this.emoji})
      : super(key: key);
  final void Function() onTap;
  final String emoji;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60,
            width: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/img.png'),
            ),
            decoration: BoxDecoration(
              color: const Color(0xff2D84C8),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}
