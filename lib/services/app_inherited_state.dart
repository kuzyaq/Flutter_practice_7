import 'package:flutter/material.dart';
import 'auth_service.dart';

class AppInheritedState extends InheritedWidget {
  final AuthService authService;

  const AppInheritedState({
    super.key,
    required super.child,
    required this.authService,
  });


  static AppInheritedState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppInheritedState>();
  }

  @override
  bool updateShouldNotify(AppInheritedState oldWidget) {
    return oldWidget.authService != authService;
  }
}