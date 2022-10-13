import 'package:flutter/material.dart';

// @param widget: generic widget: container, colunm, tetx, etc
// @param height: size fot the focus box's height
// @param width: size for the focus box's width
// @return the focus box with the choosen size and widget to show
Container getFocusBox(Widget widget, double height, double width) {
  return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          color: Color.fromARGB(140, 0, 0, 0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(40.0))),
      child: widget);
}
