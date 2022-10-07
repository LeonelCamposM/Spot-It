import 'package:flutter/material.dart';

Container getFocusBox(Column column, double height, double width) {
  return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          color: Color.fromARGB(140, 0, 0, 0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(40.0))),
      child: column);
}
