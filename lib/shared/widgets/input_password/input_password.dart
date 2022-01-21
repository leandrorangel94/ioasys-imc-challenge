import 'package:flutter/material.dart';
import 'package:imc_challenge/shared/theme/app_theme.dart';

class InputPassword extends StatefulWidget {
  final String hintText;
  final String? Function(String?) validator;
  final Function(String)? onChanged;

  const InputPassword({
    Key? key,
    required this.hintText,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: isVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: isVisible
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.white,
                    )),
          labelText: 'senha',
          hintText: 'digite sua senha',
          hintStyle: AppTheme.textStyles.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.pinkAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
              ))),
    );
  }
}
