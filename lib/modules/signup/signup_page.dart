import 'package:flutter/material.dart';
import 'package:imc_challenge/modules/login/login_page.dart';
import 'package:imc_challenge/modules/signup/repositories/signup_repository_impl.dart';
import 'package:imc_challenge/modules/signup/signup_controller.dart';
import 'package:imc_challenge/shared/services/app_database.dart';
import 'package:imc_challenge/shared/theme/app_theme.dart';
import 'package:imc_challenge/shared/widgets/button_widget.dart/button_widget.dart';
import 'package:imc_challenge/shared/widgets/custom_input_text/custom_input_text.dart';
import 'package:imc_challenge/shared/widgets/input_password/input_password.dart';
import 'package:validatorless/validatorless.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

bool isLoading = false;

class _SignupPageState extends State<SignupPage> {
  late final SignupController signUpController;

  @override
  void initState() {
    signUpController =
        SignupController(SignupRepositoryImpl(AppDatabase.instance));
    signUpController.state.when(
        success: (value) => Navigator.pop(context),
        orElse: () {},
        error: (message, _) =>
            scaffoldKey.currentState!.showBottomSheet((context) => BottomSheet(
                onClosing: () {},
                builder: (context) => Text(
                      message,
                      style: AppTheme.textStyles.hint,
                    ))));
    super.initState();
  }

  @override
  void dispose() {
    signUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppTheme.colors.secondary,
        appBar: AppBar(
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: AppTheme.colors.secondary,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 57, right: 52, left: 52, bottom: 301),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 38,
                ),
                const Text(
                  'Criando uma conta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Cadastre-se e faça o calculo do seu IMC',
                  style: AppTheme.textStyles.hint,
                ),
                const SizedBox(
                  height: 56,
                ),
                Form(
                    key: signUpController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInputText(
                          label: const Text(
                            "nome",
                            style: TextStyle(color: Colors.white),
                          ),
                          onChanged: (value) {
                            signUpController.onChange(nome: value);
                          },
                          hint: 'Insira o seu nome',
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.min(
                                2, 'Minimo de 2 letras para o nome'),
                          ]),
                        ),
                        const SizedBox(height: 28),
                        CustomInputText(
                            label: const Text("e-mail",
                                style: TextStyle(color: Colors.white)),
                            onChanged: (value) {
                              signUpController.onChange(email: value);
                            },
                            hint: 'Insira o seu e-mail',
                            validator: Validatorless.multiple([
                              Validatorless.required('Campo obrigatório!'),
                              Validatorless.email('email inválido!')
                            ])),
                        const SizedBox(height: 28),
                        InputPassword(
                          onChanged: (value) {
                            signUpController.onChange(password: value);
                          },
                          hintText: 'Insira sua senha',
                          validator: Validatorless.multiple([
                            Validatorless.multiple([
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.min(6, 'Minimo de 6 caracteres!'),
                            ])
                          ]),
                        )
                      ],
                    )),
                const SizedBox(height: 20),
                AnimatedBuilder(
                    animation: signUpController,
                    builder: (_, __) => signUpController.state.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        orElse: () => Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: ButtonWidget(
                                    text: 'Criar Conta'.toUpperCase(),
                                    onPressed: () {
                                      signUpController.create();
                                    },
                                    primary: AppTheme.colors.primary,
                                    style: AppTheme
                                        .textStyles.buttonBackgroundColor,
                                  ),
                                ),
                                const SizedBox(height: 22),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Já tem uma conta? Faça Login!',
                                      style: AppTheme.textStyles.hint,
                                    ),
                                  ),
                                ),
                              ],
                            )))
              ],
            ),
          ),
        ));
  }
}
