import 'package:flutter/material.dart';

class DialogBox {
  information(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext cotext) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(description),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  return Navigator.pop(context);
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }
}
