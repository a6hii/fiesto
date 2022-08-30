import 'package:fiesto/constants.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NotificationCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            Cards.kcard3,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
