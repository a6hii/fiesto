import 'package:flutter/material.dart';

class CreateCardText extends StatelessWidget {
  const CreateCardText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Get Instant Notification',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Instant notification about any transaction',
          style: TextStyle(color: Colors.white38, fontSize: 16),
        )
      ],
    );
  }
}
