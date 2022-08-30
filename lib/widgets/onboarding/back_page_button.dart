import 'package:flutter/material.dart';

class BackPage extends StatelessWidget {
  final VoidCallback onPressed;
  final int currentPage;
  const BackPage({
    super.key,
    required this.onPressed,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: currentPage != 1
          ? const Text(
              '<< Back',
              style: TextStyle(color: Colors.blue),
            )
          : const Text(
              'Skip',
              style: TextStyle(color: Colors.blue),
            ),
    );
  }
}
