import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/i_room_repository.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

class RoomRepository implements IRoomRepository {
  final CollectionReference<Room> _roomsCollection;

  RoomRepository(FirebaseFirestore firestore)
      : _roomsCollection = firestore.collection('Room').withConverter<Room>(
              fromFirestore: (doc, options) => Room.fromJson(doc.data()!),
              toFirestore: (employee, options) => employee.toJson(),
            );

  @override
  Future<String> createRoom(Room room) async {
    final reference = await _roomsCollection.add(room);
    return reference.id;
  }

  @override
  Future<void> updateJoinable(String roomID) async {
    await _roomsCollection.doc(roomID).update(Room(1, false).toJson());
  }

  @override
  Future<void> onJoinableUpdate(BuildContext context, GameRoomArgs args) async {
    FirebaseFirestore.instance
        .collection("Room")
        .doc(args.roomID)
        .snapshots()
        .listen((event) {
      Map<String, dynamic> data = event.data()!;
      if (data["joinable"] == false) {
        Navigator.pushNamed(context, GamePage.routeName, arguments: args);
      }
    });
  }
}
