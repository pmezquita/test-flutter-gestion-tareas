import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class AlertDialog2Opt extends StatelessWidget {
  final String title;
  final String content;
  final String? opt1Text;
  final String? opt2Text;
  final VoidCallback? onPressed1Opt;
  final VoidCallback? onPressed2Opt;

  const AlertDialog2Opt(
      {Key? key,
      required this.title,
      required this.content,
      this.opt1Text,
      this.opt2Text,
      this.onPressed1Opt,
      this.onPressed2Opt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: Text(content, textAlign: TextAlign.center),
      actions: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: onPressed1Opt,
              style: ElevatedButton.styleFrom(
                foregroundColor: secondary,
                backgroundColor: Colors.white,
                side: const BorderSide(color: secondary),
              ),
              child: const Text('No'),
            )),
            const SizedBox(width: 30.0),
            Expanded(child: ElevatedButton(onPressed: onPressed2Opt, child: const Text('Sí'))),
          ],
        ),
      ],
    );
  }
}
