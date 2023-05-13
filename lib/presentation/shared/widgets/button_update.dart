import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
class ButtonUpdate extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const ButtonUpdate({Key? key, required this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: Theme.of(context).textTheme.displaySmall,
        foregroundColor: secondary,
        backgroundColor: secondaryLight,
        side: const BorderSide(color: secondary),
      ),
      label: Text(text, style: Theme.of(context).textTheme.displaySmall),
      icon: const Icon(Icons.edit_outlined),
    );
  }
}
