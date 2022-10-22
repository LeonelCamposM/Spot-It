import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/i_room_repository.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/presentation/game/game.dart';

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
    await _roomsCollection.doc(roomID).update(Room(1, true).toJson());
  }

  @override
  Future<void> onJoinableUpdate(BuildContext context) async {
    FirebaseFirestore.instance.collection("/Room").snapshots().listen((event) {
      for (var change in event.docChanges) {
        if (change.doc['joinable'] == true) {
          Navigator.pushNamed(context, GamePage.routeName);
        }
      }
    });
  }
}
