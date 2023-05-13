import 'package:flutter/material.dart';
import 'package:gestion_tareas/theme/app_theme.dart';

InputDecoration textFieldDecoration({
  String hint = '',
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? onPressedSuffixIcon,
  bool enabled = true,
}) {
  return InputDecoration(

    filled: !enabled,
    fillColor: enabled ? null : primary90,
    hintText: hint,
    prefixIcon: prefixIcon != null ? Padding(padding: const EdgeInsets.all(14.5), child: Icon(prefixIcon)) : null,
    suffixIcon: suffixIcon != null
        ? IconButton(
            icon: Icon(suffixIcon),
            onPressed: onPressedSuffixIcon,
          )
        : null,
  );
}
