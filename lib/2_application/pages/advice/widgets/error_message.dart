import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.redAccent,
          size: 40,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          message,
          style: themeData.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
