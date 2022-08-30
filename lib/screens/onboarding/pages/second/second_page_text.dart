import 'package:flutter/material.dart';

class NotificationText extends StatelessWidget {
  const NotificationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Hiiiii',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Instant offers any transaction',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
