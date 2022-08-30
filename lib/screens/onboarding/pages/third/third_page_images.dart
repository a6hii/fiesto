import 'package:fiesto/constants.dart';
import 'package:flutter/material.dart';

class OwnCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const OwnCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            Cards.kcard2,
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }
}
