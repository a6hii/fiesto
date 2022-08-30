import 'package:flutter/material.dart';

class CardsStack extends StatelessWidget {
  final int pageNumber;
  final Widget darkCardChild;
  //final Animation<Offset> lightCardOffsetAnimation;
  final Animation<Offset> darkCardOffsetAnimation;

  const CardsStack({
    super.key,
    required this.pageNumber,
    required this.darkCardChild,
    //required this.lightCardOffsetAnimation,
    required this.darkCardOffsetAnimation,
  });

  bool get isOddPageNumber => pageNumber % 2 == 1;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: darkCardOffsetAnimation,
      child: SizedBox(
          height: 500,
          child: Center(
            child: darkCardChild,
          )),
    );
  }
}
