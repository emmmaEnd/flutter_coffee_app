import 'package:flutter/material.dart';
import 'package:pryandroid/screens/home_screen.dart';
import 'package:pryandroid/screens/login_screen.dart';
import 'package:pryandroid/screens/register_screen.dart';
import 'package:pryandroid/utils/theme_app.dart';
import 'package:pryandroid/utils/value_listener.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
    valueListenable: ValueListener.isDark,
      builder: (context, value,_) {
        return MaterialApp(
          theme: value ? ThemeApp.darkTheme() : ThemeApp.lightTheme(),
          routes: {
            "/home": (context) => const HomeScreen(),
            "/register": (context) => const RegisterScreen(),
          },
          title: 'Material App',
          home: Theme( // ← tema local SOLO para LoginScreen
            data: ThemeApp.lightTheme(),
            child: const LoginScreen(),
          ),
        );
      }
    );
  }
}