import 'package:flutter/material.dart';

class RadialWhiteCenterGradient extends StatelessWidget {
  const RadialWhiteCenterGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.5,
          colors: [
            //Color.fromARGB(255, 185, 57, 136),
            Colors.white12,
            Colors.transparent
          ],
        ),
      ),
    );
  }
}
