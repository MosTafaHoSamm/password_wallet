import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeOption {
  static ThemeData theme({required bool isDark}) => ThemeData(
           scaffoldBackgroundColor: isDark
            ? const Color.fromARGB(255, 36, 52, 71)
            : const Color.fromARGB(255, 255, 255, 255),
        primarySwatch: Colors.green,
        primaryColor: isDark
            ? const Color.fromARGB(255, 36, 52, 71)
            : const Color.fromARGB(255, 255, 255, 255),
         backgroundColor: isDark
            ? const Color.fromARGB(255, 36, 52, 71)
            : const Color.fromARGB(255, 255, 255, 255),
        cardColor: isDark
            ? const Color.fromARGB(255, 36, 52, 71)
            : const Color.fromARGB(255, 255, 255, 255),
        indicatorColor: isDark
            ? const Color.fromARGB(255, 36, 52, 71)
            : const Color.fromARGB(255, 255, 255, 255),
        hintColor: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
        highlightColor:
            isDark ? const Color(0xff372901) : const Color(0xffFCE192),
        hoverColor: isDark ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
        focusColor: isDark ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        textSelectionColor: isDark ? Colors.white : Colors.black,
        canvasColor: isDark ? Colors.black : Colors.grey[50],
        brightness: isDark ? Brightness.dark : Brightness.light,



      );
  static  Color primarySwatch= Colors.green;

}
