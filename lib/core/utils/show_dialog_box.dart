import 'package:flutter/material.dart';

Future<void> showDialogBox(
    BuildContext context, VoidCallback okFunction) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Do you want to delete this blog"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              okFunction();
              Navigator.of(context).pop();
            },
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"),
          ),
        ],
      );
    },
  );
}
