import 'package:flutter/material.dart';

class OwnCardText extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const OwnCardText();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Welcome',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Continue',
          style: TextStyle(color: Colors.white38, fontSize: 16),
        )
      ],
    );
  }
}
