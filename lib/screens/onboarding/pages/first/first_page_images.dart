import 'package:fiesto/constants.dart';
import 'package:flutter/material.dart';

class CreateCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CreateCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              Cards.kcard1,
              fit: BoxFit.cover,
            ))
      ],
    );
  }
}
