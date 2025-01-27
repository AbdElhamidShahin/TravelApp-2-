
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showWarningDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('تحذير',
            style:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        content: const Text(
          'هذه رسالة تحذير.',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('موافق'),
          ),
        ],
      );
    },
  );
}

