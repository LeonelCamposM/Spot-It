import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/chat/message.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

import '../../../presentation/waiting_room/colors.dart';

// ignore: must_be_immutable
class OnJoinableUpdate extends StatelessWidget {
  String roomID;
  late Stream<QuerySnapshot> _usersStream;
  OnJoinableUpdate({Key? key, required this.roomID}) : super(key: key) {
    _usersStream = FirebaseFirestore.instance.collection('Room').snapshots();
  }
  final List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: SizeConfig.blockSizeVertical * 85,
              width: SizeConfig.blockSizeHorizontal * 50,
              child: const Text(''));
        }

        List<Room> messages = getAllMessages(snapshot, roomID);
        if (messages.first.joinable == false) {
          return getTextButton(
              "Ingresar",
              SizeConfig.safeBlockHorizontal * 20,
              SizeConfig.safeBlockVertical * 10,
              SizeConfig.safeBlockHorizontal * 2,
              getSecondaryColor(), () {
            Navigator.pushNamed(context, GamePage.routeName,
                arguments: GameRoomArgs(true, roomID));
          });
        } else {
          return Text(messages.first.joinable.toString());
        }
      },
    );
  }
}

// @param snapshot: enventListener on database
// @return sorted by timestamp list of messages
List<Room> getAllMessages(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot, roomID) {
  // Get all chat messages from snapshot
  List<Room> messages = [];
  ListView(
    children: snapshot.data!.docs
        .map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          if (document.id == roomID) {
            messages.add(Room(data['round'], data["joinable"]));
          }
        })
        .toList()
        .cast(),
  );

  return messages;
}
