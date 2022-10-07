import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/input_field.dart';

IconButton openChat(context, Color secondaryColor, Color primaryColor) {
  return IconButton(
    iconSize: getIconSize(),
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: const EdgeInsets.only(top: 10.0),
                backgroundColor: primaryColor,
                // ignore: prefer_const_literals_to_create_immutables
                content: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: prefer_const_constructors
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          getIconButtonStyle(
                              secondaryColor,
                              IconButton(
                                iconSize: 30.0,
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      const Text("message"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: getInputField(" Ingrese un mensaje"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: getIconButtonStyle(
                                secondaryColor,
                                IconButton(
                                  iconSize: 30.0,
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                ]));
          });
    },
    icon: const Icon(Icons.chat),
  );
}
