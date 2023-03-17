import 'package:flutter/material.dart';

class CustomColors {
  static const Color primary = Color(0xFFFA4D14);
  // static const Color secondary = Color(0xFFFD8D39);

  static const Color error = Color(0xFFFF0000);
  static const Color warning = Color(0xFFFF9800);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F9FA);
  static const Color green = Color(0xFF198754);

  static const Color black = Color(0xFF000000);

  static const Color darkGrey = Color(0xFF626164);
  static const Color grey = Color(0xFFB5B1B1);
  static const Color lightgrey = Color(0xFFDDDDDD);

  MaterialColor primaryColorCustom = MaterialColor(0xFFFA4D14, color);
  static Map<int, Color> color = {
    50: const Color.fromRGBO(250, 77, 20, .1),
    100: const Color.fromRGBO(250, 77, 20, .2),
    200: const Color.fromRGBO(250, 77, 20, .3),
    300: const Color.fromRGBO(250, 77, 20, .4),
    400: const Color.fromRGBO(250, 77, 20, .5),
    500: const Color.fromRGBO(250, 77, 20, .6),
    600: const Color.fromRGBO(250, 77, 20, .7),
    700: const Color.fromRGBO(250, 77, 20, .8),
    800: const Color.fromRGBO(250, 77, 20, .9),
    900: const Color.fromRGBO(250, 77, 20, 1),
  };
}
