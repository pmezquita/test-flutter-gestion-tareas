import 'package:flutter/material.dart';

class AlertDialogError extends StatelessWidget {
  final String msg;

  const AlertDialogError({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(msg, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall),

      actions: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Aceptar'))),
          ],
        ),
      ],
    );
  }
}
