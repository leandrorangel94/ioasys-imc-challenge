import 'package:flutter/material.dart';
import 'package:imc_challenge/modules/calculator/calculator_page.dart';
import 'package:imc_challenge/shared/theme/app_theme.dart';

//import 'modules/home/home_page.dart';
import 'modules/login/login_page.dart';
import 'modules/signup/signup_page.dart';
import 'modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter IMC",
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      theme: ThemeData(primaryColor: AppTheme.colors.primary),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/login": (context) => const LoginPage(),
        "/home": (context) => const CalculatorPage(),
        "/signup": (context) => const SignupPage(),
      },
    );
  }
}
