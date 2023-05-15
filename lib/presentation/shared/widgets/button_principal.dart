import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class ButtonPrincipal extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final IconData? icon;
  final VoidCallback? onPressed;

  const ButtonPrincipal({
    Key? key,
    required this.text,
    this.isPrimary = true,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: isPrimary
          ? Theme.of(context).elevatedButtonTheme.style
          : ElevatedButton.styleFrom(backgroundColor: secondary),
      label: Text(text),
      icon: (icon != null) ? Icon(icon) : const SizedBox.shrink(),
    );
  }
}
