import 'package:flutter/material.dart';

class LinkAndText extends StatelessWidget {
  final String normalText;
  final String? linkText;
  final Function()? onpressed;
  final MainAxisAlignment? mainAxisAlignment;
  const LinkAndText(
      {super.key,
      required this.normalText,
      this.linkText,
      this.onpressed,
      this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment!,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          normalText,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 12,
          ),
        ),
        TextButton(
          onPressed: onpressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          child: Text(
            linkText!,
            style: TextStyle(
              color: Colors.blue[200],
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
