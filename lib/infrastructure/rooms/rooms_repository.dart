import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/i_room_repository.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/infrastructure/rooms/eventListeners/eventListeners/on_joinable_update.dart';
import 'package:spot_it_game/presentation/game/game.dart';

class RoomRepository implements IRoomRepository {
  final CollectionReference<Room> _roomsCollection;

  RoomRepository(FirebaseFirestore firestore)
      : _roomsCollection = firestore.collection('rooms').withConverter<Room>(
              fromFirestore: (doc, options) => Room.fromJson(doc.data()!),
              toFirestore: (employee, options) => employee.toJson(),
            );

  @override
  Future<String> createRoom(Room room) async {
    final reference = await _roomsCollection.add(room);
    return reference.id;
  }

  @override
  Widget onJoinableUpdate(BuildContext buildContext) {
    return OnJoinableUpdate(context: buildContext);
  }
}
