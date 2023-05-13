import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  final VoidCallback? onPressed;

  const Fab({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: onPressed,
          child: const Icon(Icons.add, size: 50.0),
        ),
      ),
    );
  }
}
