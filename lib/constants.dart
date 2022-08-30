import 'package:flutter/material.dart';

// Colors

const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Colors.grey;
const Color kBlack = Colors.black;

// Padding
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;

// Spacing
const double kSpaceS = 8.0;
const double kSpaceM = 16.0;

// Animation
const Duration kButtonAnimationDuration = Duration(milliseconds: 600);
const Duration kCardAnimationDuration = Duration(milliseconds: 400);
const Duration kRippleAnimationDuration = Duration(milliseconds: 400);
const Duration kLoginAnimationDuration = Duration(milliseconds: 1500);

//Login

const List<Color> orangeGradients = [
  Color.fromARGB(255, 255, 121, 190),
  //Color.fromARGB(255, 173, 214, 1),
  Color.fromARGB(255, 106, 219, 204),
];
const List<Color> aquaGradients = [
  Color(0xFF9FA3BF),
  Color(0xFFFFA172),
];

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

// Assets
class Cards {
  static const String kcard1 = 'assets/images/2.png';
  static const String kcard2 = 'assets/images/64.png';
  static const String kcard3 = 'assets/images/65.png';
}

//home
enum MenuAction { logout }
