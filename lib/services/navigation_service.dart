import 'package:flutter/material.dart';

class NavigationService {
  // Страничная навигация (вертикальная)
  static void pushScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Горизонтальная навигация (замена экрана)
  static void pushReplacementScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Возврат с результатом
  static void popWithResult<T>(BuildContext context, T result) {
    Navigator.pop(context, result);
  }
}