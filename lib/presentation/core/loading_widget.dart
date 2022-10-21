import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

Widget getLoadingWidget(Color secondaryColor, double width, double heigth) {
  return SizedBox(
      width: width,
      height: heigth,
      child: CircularProgressIndicator(color: secondaryColor));
}
