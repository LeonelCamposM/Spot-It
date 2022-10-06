import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/card_button.dart';
import 'package:spot_it_game/presentation/core/input_field.dart';

IconButton openChat(context) {
  return IconButton(
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: const EdgeInsets.only(top: 10.0),
                backgroundColor: Color.fromARGB(255, 156, 33, 201),
                // ignore: prefer_const_literals_to_create_immutables
                content: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: prefer_const_constructors
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          getIconButton(Icons.close),
                          const SizedBox(
                            width: 20,
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
                          getInputField(" Ingrese un mensaje"),
                          getIconButton(Icons.send),
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
