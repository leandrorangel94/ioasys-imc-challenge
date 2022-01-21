import 'package:flutter/material.dart';
import 'package:imc_challenge/shared/theme/app_theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomInputText extends StatelessWidget {
  final String? Function(String?) validator;
  final String? hint;
  final Widget? label;
  final TextInputType? keyboard;
  final Function(String)? onChanged;
  final List<MaskTextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  const CustomInputText({
    Key? key,
    required this.validator,
    required this.hint,
    this.label,
    this.keyboard,
    this.onChanged,
    this.inputFormatters,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboard,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: label,
        hintText: hint,
        hintStyle: AppTheme.textStyles.hint,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.pinkAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
