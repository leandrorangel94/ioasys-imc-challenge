import 'package:flutter/material.dart';
import 'package:imc_challenge/shared/theme/app_theme.dart';
import 'package:imc_challenge/shared/widgets/button_widget.dart/button_widget.dart';
import 'package:imc_challenge/shared/widgets/custom_input_text/custom_input_text.dart';
import 'package:validatorless/validatorless.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  String _textInfo = "Informe seus dados";

  void _calculaImc() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    double imc = weight / (height * height);

    if (imc < 18.6) {
      _textInfo = "Você está abaixo do peso ${imc.toStringAsFixed(2)}";
    } else if (imc >= 18.6 && imc < 24.9) {
      _textInfo = "Você está no peso ideal ${imc.toStringAsFixed(2)}";
    } else if (imc >= 24.9 && imc < 29.9) {
      _textInfo = "Você está levemente acima do peso ${imc.toStringAsFixed(2)}";
    } else if (imc >= 29.9 && imc < 34.9) {
      _textInfo = "Você está com obesidade grau I ${imc.toStringAsFixed(2)}";
    } else if (imc >= 34.9 && imc < 39.9) {
      _textInfo = "Você está com obesidade grau II ${imc.toStringAsFixed(2)}";
    } else {
      _textInfo = "Você está com obesidade grau III ${imc.toStringAsFixed(2)}";
    }
  }

  void _resetFields() {
    heightController.clear();
    weightController.clear();
    _textInfo = "Informe seus dados";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.secondary,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.primary,
        centerTitle: true,
        leading: Image.asset(
          'assets/images/logo_home.png',
        ),
        title: const Text('Calculadora IMC'),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _resetFields();
              });
            },
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.refresh)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 36),
                child: Image.asset(
                  'assets/images/workout.png',
                  fit: BoxFit.cover,
                  width: 200,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 300,
                height: 50,
                child: CustomInputText(
                  keyboard: TextInputType.number,
                  controller: weightController,
                  label: const Text('Peso (Kg)'),
                  hint: 'Insira seu peso em quilos',
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo obrigatório!'),
                    Validatorless.number("Insira somente números"),
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: CustomInputText(
                  keyboard: TextInputType.number,
                  controller: heightController,
                  label: const Text('Altura (cm)'),
                  hint: 'Insira a sua altura em centímetros',
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo obrigatório!'),
                    Validatorless.number("Insira somente números"),
                  ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 33.5),
                width: 300,
                height: 50,
                child: ButtonWidget(
                  onPressed: () {
                    setState(() {
                      _calculaImc();
                    });
                  },
                  text: 'Calcular'.toUpperCase(),
                  primary: AppTheme.colors.primary,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                "Resultado: $_textInfo",
                style: const TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 500,
                child: TextButton(
                  child: Text(
                    'Sair do aplicativo',
                    style: AppTheme.textStyles.hint,
                  ),
                  onPressed: () {
                    Navigator.pop(context, '/splash');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
