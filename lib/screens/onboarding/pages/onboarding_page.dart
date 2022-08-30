import 'package:fiesto/constants.dart';
import 'package:fiesto/widgets/onboarding/cards_stack.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final int number;
  final Widget darkCardChild;
  //final Animation<Offset> lightCardOffsetAnimation;
  final Animation<Offset> darkCardOffsetAnimation;
  final Widget textColumn;

  const OnboardingPage({
    Key? key,
    required this.number,
    required this.darkCardChild,
    //required this.lightCardOffsetAnimation,
    required this.darkCardOffsetAnimation,
    required this.textColumn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CardsStack(
          pageNumber: number,
          darkCardChild: darkCardChild,
          //lightCardOffsetAnimation: lightCardOffsetAnimation,
          darkCardOffsetAnimation: darkCardOffsetAnimation,
        ),
        AnimatedSwitcher(
          duration: kCardAnimationDuration,
          child: textColumn,
        ),
      ],
    );
  }
}
