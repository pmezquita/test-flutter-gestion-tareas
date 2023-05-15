import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class ButtonSecondary extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Icon? icon;

  const ButtonSecondary({Key? key, required this.text, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: secondary,
        backgroundColor: secondaryLight,
        side: const BorderSide(color: secondary),
      ),
      label: Text(text),
      icon: icon ?? const Icon(Icons.edit_outlined),
    );
  }
}
