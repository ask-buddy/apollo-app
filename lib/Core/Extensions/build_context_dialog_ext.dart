import 'package:flutter/material.dart';

extension DialogExt on BuildContext {
  Future<void> showErrorDialog({
    required String errorTitle,
    required String errorMessage,
  }) {
    return showDialog<void>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(errorTitle),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
