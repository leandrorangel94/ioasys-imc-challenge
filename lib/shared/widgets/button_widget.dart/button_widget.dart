import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final BorderSide? borderSide;
  final String text;
  final void Function()? onPressed;
  final Color primary;
  final TextStyle style;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.primary,
      required this.style,
      this.borderSide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: style,
      ),
      style: ElevatedButton.styleFrom(
          side: borderSide,
          fixedSize: const Size(350, 57),
          primary: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
