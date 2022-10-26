import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/players/i_player_repository.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/infrastructure/players/eventListeners/on_players_update.dart';

class PlayerRepository implements IPlayerRepository {
  final CollectionReference<Player> _playersCollection;

  PlayerRepository(FirebaseFirestore firestore)
      : _playersCollection =
            firestore.collection('Room_Player').withConverter<Player>(
                  fromFirestore: (doc, options) => Player.fromJson(doc.data()!),
                  toFirestore: (employee, options) => employee.toJson(),
                );

  @override
  Future<String> addPlayer(Player player, String roomID) async {
    final reference = _playersCollection.doc(roomID).collection("players");
    final newPlayer = await reference.add(player.toJson());
    return newPlayer.id;
  }

  @override
  Widget onPlayersUpdate(String roomID) {
    return OnPlayersUpdate(roomID: roomID);
  }

  @override
  Future<List<Player>> getPlayers(String roomID) async {
    final collection =
        await _playersCollection.doc(roomID).collection("players").get();
    List<Player> result = [];
    collection.docs
        .map((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          result.add(Player(
              data['nickname'],
              data['icon'],
              data['displayedCard'],
              data['cardCount'],
              data['stackCardsCount']));
        })
        .toList()
        .cast();
    return result;
  }
}
