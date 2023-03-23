import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stoktakip/auth/register/view/register_view.dart';
import 'package:stoktakip/home/view/home_view.dart';
import 'package:stoktakip/landing/view/landing_view.dart';
import 'package:stoktakip/auth/login/view/login_view.dart';
import 'package:stoktakip/shared/model/model_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ModelTheme(),
        child: Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeNotifier.isDark
                ? ThemeData(
                    brightness: Brightness.dark,
                  )
                : ThemeData(
                    brightness: Brightness.light,
                    primaryColor: Colors.black26,
                    primarySwatch: Colors.grey),
            routes: {
              '/': (context) => const LandingView(),
              '/login': (context) => const LoginView(),
              '/register': (context) => const RegisterView(),
              '/home': (context) => const HomeView(),
            },
          );
        }));
  }
}
