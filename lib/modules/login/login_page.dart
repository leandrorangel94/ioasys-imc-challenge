import 'package:flutter/material.dart';
import 'package:imc_challenge/modules/login/repositories/login_repository_impl.dart';
import 'package:imc_challenge/shared/services/app_database.dart';
import 'package:imc_challenge/shared/theme/app_theme.dart';
import 'package:imc_challenge/shared/widgets/button_widget.dart/button_widget.dart';
import 'package:imc_challenge/shared/widgets/custom_input_text/custom_input_text.dart';
import 'package:imc_challenge/shared/widgets/input_password/input_password.dart';
import 'package:validatorless/validatorless.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _LoginPageState extends State<LoginPage> {
  late final LoginController loginController;
  @override
  void initState() {
    loginController =
        LoginController(LoginRepositoryImpl(AppDatabase.instance));
    loginController.addListener(() {
      loginController.state.when(
        success: (value) =>
            Navigator.pushNamed(context, '/home', arguments: value),
        error: (message, _) =>
            scaffoldKey.currentState!.showBottomSheet((context) => BottomSheet(
                onClosing: () {},
                builder: (context) => Text(
                      message,
                      style: AppTheme.textStyles.hint,
                    ))),
        orElse: () {},
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppTheme.colors.secondary,
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 35, bottom: 159, left: 26, right: 29),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 140),
                    Image.asset(
                      'assets/images/logo_ioasys.png',
                      fit: BoxFit.cover,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 41,
                    ),
                    Form(
                        key: loginController.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Seja bem-vindo!",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 31),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Faça login e realize o cálculo de seu IMC",
                              style: AppTheme.textStyles.hint,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomInputText(
                              onChanged: (value) {
                                loginController.onChange(email: value);
                              },
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório!'),
                                Validatorless.email('email inválido!')
                              ]),
                              hint: 'digite seu e-mail',
                              label: const Text(
                                'e-mail',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputPassword(
                              onChanged: (value) {
                                loginController.onChange(password: value);
                              },
                              validator: Validatorless.multiple([
                                Validatorless.multiple([
                                  Validatorless.required('Campo obrigatório'),
                                  Validatorless.min(
                                      6, 'Minimo de 6 caracteres!'),
                                ])
                              ]),
                              hintText: 'senha',
                            )
                          ],
                        )),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                        animation: loginController,
                        builder: (_, __) => loginController.state.when(
                            loading: () => const CircularProgressIndicator(
                                  color: Color(0xFFC1007E),
                                ),
                            orElse: () => Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ButtonWidget(
                                        primary: AppTheme.colors.primary,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        text: 'Entrar'.toUpperCase(),
                                        onPressed: () {
                                          loginController.login();
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 19),
                                        child: ButtonWidget(
                                          text: 'Cadastrar'.toUpperCase(),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/signup');
                                          },
                                          primary: Colors.white,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<bool> onWillPop() async {
    final pop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Tem certeza'),
              content: const Text('Quer sair do app?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('não')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Sim')),
              ],
            ));
    return pop ?? false;
  }
}
