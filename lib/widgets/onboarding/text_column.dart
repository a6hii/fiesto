import 'package:fiesto/constants.dart';
import 'package:flutter/material.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  const TextColumn({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: kBlack, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: kSpaceS),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kGrey),
        ),
      ],
    );
  }
}
