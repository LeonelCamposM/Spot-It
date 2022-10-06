import 'package:flutter/material.dart';

Card getInputField(String inputMessage) {
  Color backgroundColor = Color.fromRGBO(255, 255, 255, 1);
  return Card(
    elevation: 10,
    color: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    // ignore: prefer_const_constructors
    child: SizedBox(
      width: 600,
      height: 50,
      // ignore: prefer_const_constructors
      child: SizedBox(
        child: SizedBox(
          width: 600,
          height: 50,
          child: TextField(
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "  " + inputMessage,
                hintStyle: const TextStyle(color: Colors.black)),
          ),
        ),
      ),
    ),
  );
}
