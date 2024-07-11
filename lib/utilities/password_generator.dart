import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void generatePassword(BuildContext context) async {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String pass =
      List.generate(8, (index) => chars[r.nextInt(chars.length)]).join();

  Clipboard.setData(ClipboardData(text: pass))
      .then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Generated Password copied to your Clipboard"),
          ),
        ),
      )
      .onError(
        (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.toString(),
            ),
          ),
        ),
      );
}
