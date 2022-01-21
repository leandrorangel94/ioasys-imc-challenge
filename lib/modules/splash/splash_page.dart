import 'package:flutter/material.dart';
import 'package:imc_challenge/shared/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4))
        .then((value) => Navigator.pushNamed(context, '/login'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.secondary,
      body: Center(
        child: Image.asset('assets/images/logo_ioasys.png'),
      ),
    );
  }
}
