import 'package:flutter/material.dart';
import 'package:pryandroid/screens/home_screen.dart';
import 'package:pryandroid/screens/login_screen.dart';
import 'package:pryandroid/screens/register_screen.dart';
import 'package:pryandroid/screens/product_detail.dart';
import 'package:pryandroid/screens/cart_screen.dart';
import 'package:pryandroid/screens/profile_screen.dart';
import 'package:pryandroid/models/product.dart';
import 'package:pryandroid/utils/theme_app.dart';
import 'package:pryandroid/utils/value_listener.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ValueListener.isDark,
      builder: (context, value, _) {
        return MaterialApp(
          theme: value ? ThemeApp.lightTheme() : ThemeApp.darkTheme(),
          routes: {
            "/home": (context) => const HomeScreen(),
            "/register": (context) => const RegisterScreen(),
            "/cart": (context) => const CartScreen(),
            "/profile": (context) => const ProfileScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == "/product") {
              final product = settings.arguments as Product;
              return MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              );
            }
            return null;
          },
          title: 'Material App',
          home: Theme(
            data: ThemeApp.lightTheme(),
            child: const LoginScreen(),
          ),
        );
      },
    );
  }
}
