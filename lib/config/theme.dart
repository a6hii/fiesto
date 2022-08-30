import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    primaryColor: const Color.fromARGB(255, 16, 110, 12),
    primaryColorDark: const Color.fromARGB(255, 0, 0, 0),
    primaryColorLight: const Color.fromARGB(255, 34, 212, 34),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    backgroundColor: const Color(0xffF5f5f5),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        actionsIconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 24)),
    fontFamily: 'Futura',
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      headline2: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline3: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline5: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyText2: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    primaryColor: const Color.fromARGB(255, 16, 110, 12),
    primaryColorDark: const Color.fromARGB(255, 0, 0, 0),
    primaryColorLight: const Color.fromARGB(255, 34, 212, 34),
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
    backgroundColor: const Color.fromARGB(255, 14, 14, 14),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      actionsIconTheme:
          IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      titleTextStyle:
          TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 24),
    ),
    fontFamily: 'Futura',
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color.fromARGB(255, 248, 248, 248),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      headline2: TextStyle(
        color: Color.fromARGB(255, 248, 248, 248),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline3: TextStyle(
        color: Color.fromARGB(255, 248, 248, 248),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Color.fromARGB(255, 248, 248, 248),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline5: TextStyle(
        color: Color.fromARGB(255, 248, 248, 248),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Color.fromARGB(255, 248, 248, 248),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Color.fromARGB(255, 248, 248, 248),
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyText2: TextStyle(
        color: Color.fromARGB(255, 248, 248, 248),
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    ),
  );
}
