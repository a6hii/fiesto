import 'package:fiesto/constants.dart';
import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int currentPage;
  const NextPageButton({
    Key? key,
    required this.onPressed,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.all(kPaddingM),
      elevation: 0.0,
      shape: const CircleBorder(),
      fillColor: kWhite,
      onPressed: onPressed,
      child: currentPage != 3
          ? const Icon(
              Icons.arrow_forward,
              color: kBlack,
              size: 32.0,
            )
          : const Icon(
              Icons.login_rounded,
              color: kBlack,
              size: 32.0,
            ),
    );
  }
}
