import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

// @param context: build context
// @param inputMessage: field's message
// @return card with the input field with the choosen message
Card getInputField(
    String inputMessage, TextEditingController textController, context) {
  Color backgroundColor = const Color.fromRGBO(255, 255, 255, 1);
  return Card(
    elevation: 10,
    color: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    // ignore: prefer_const_constructors
    child: SizedBox(
      child: TextField(
        controller: textController,
        style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: SizeConfig.safeBlockVertical * 4),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "  " + inputMessage,
            hintStyle: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.safeBlockVertical * 4)),
      ),
    ),
  );
}
