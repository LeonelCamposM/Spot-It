import 'package:flutter/material.dart';

Card getInputField(String inputMessage, context) {
  Color backgroundColor = const Color.fromRGBO(255, 255, 255, 1);
  return Card(
    elevation: 10,
    color: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    // ignore: prefer_const_constructors
    child: SizedBox(
      child: TextField(
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "  " + inputMessage,
            hintStyle: const TextStyle(color: Colors.black)),
      ),
    ),
  );
}
