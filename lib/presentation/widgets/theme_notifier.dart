import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.system ? ThemeMode.dark : ThemeMode.system;
    notifyListeners();
  }
}

// InheritedWidget to provide ThemeNotifier down the widget tree
class ThemeProvider extends InheritedWidget {
  final ThemeNotifier themeNotifier;

  const ThemeProvider({
    super.key,
    required this.themeNotifier,
    required super.child,
  });

  // Static method to access ThemeNotifier from any descendant widget
  static ThemeNotifier of(BuildContext context) {
    final ThemeProvider? result =
        context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(result != null, 'No ThemeProvider found in context');
    return result!.themeNotifier;
  }

  // Optional: static method that returns null if not found (safer)
  static ThemeNotifier? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeProvider>()
        ?.themeNotifier;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeNotifier != oldWidget.themeNotifier;
  }
}
