import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

Future showCardSelection(
    context, Color secondaryColor, Color primaryColor, cardOne, cardTwo) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          backgroundColor: primaryColor,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // close button
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(""),
                        getCloseButton(secondaryColor, context),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Row(children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 25,
                          height: SizeConfig.blockSizeHorizontal * 25,
                          child: cardOne,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 25,
                          height: SizeConfig.blockSizeHorizontal * 25,
                          child: cardOne,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

// @param secondaryColor: Current page secondary color
// @param context: build context
// @return Row with close button aligned to right
Row getCloseButton(Color secondaryColor, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: getIconButtonStyle(
            secondaryColor,
            IconButton(
              iconSize: getIconSize(),
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ),
    ],
  );
}
