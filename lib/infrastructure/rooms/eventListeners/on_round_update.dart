import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/waiting_room/colors.dart';

// ignore: must_be_immutable
class OnRoundUpdate extends StatelessWidget {
  String roomID;
  late Stream<QuerySnapshot> _usersStream;

  bool isHost = true;
  OnRoundUpdate({Key? key, required this.roomID}) : super(key: key) {
    _usersStream = FirebaseFirestore.instance.collection('Room').snapshots();
  }
  final List<String> messages = [];
  int localRound = 0;
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

        Room room = getUpdateRoom(snapshot, roomID);
        if (room.round > localRound && isHost) {
          localRound += 1;
          print('Soy un wumpus y repartí cartas');
          dealCards(roomID);
          return const Text('puede obtener carta');
        } else {
          return const Text('ya obtuvo carta por esta ronda');
        }
      },
    );
  }
}

// @param snapshot: enventListener on database
// @return roomID data
Room getUpdateRoom(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, roomID) {
  // Get updated room from snapshot
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

  return messages.first;
}

Future<void> dealCards(String roomID) async {
  print("prendió");
  // Get players collection
  var collection = FirebaseFirestore.instance
      .collection('Room_Player')
      .doc(roomID)
      .collection('players');
  var snapshots = await collection.get();

  // Get deck collection
  final roomDeckReference = FirebaseFirestore.instance
      .collection('Room_Deck')
      .doc(roomID)
      .collection('Deck')
      .limit(snapshots.docs.length);

  // Get new cards
  final newCardsReference =
      await roomDeckReference.limit(snapshots.docs.length).get();
  Iterable<CardModel> cards = newCardsReference.docs
      .map((snapshot) => CardModel.fromJson(snapshot.data()));
  print("cartas obtenidas" + cards.toString());

  // en adelante
  int counter = 0;
  for (var doc in snapshots.docs) {
    // Get current player
    final query = await doc.reference.get();
    print(query.data()!);
    // Final
    Map<String, dynamic> data = query.data()!;
    final currentPlayer = Player(data['nickname'], data["icon"],
        data["displayedCard"], data["cardCount"], data["stackCardsCount"]);

    print(currentPlayer.nickname + " jugador actual");
    // Give card to user
    CardModel newCard = cards.elementAt(counter);
    counter += 1;
    print(newCard.toJson().toString() + "player carta actual");

    // Update new player card
    Player newPlayer = Player(
        currentPlayer.nickname,
        currentPlayer.icon,
        newCard.iconOne +
            ',' +
            newCard.iconTwo +
            ',' +
            newCard.iconThree +
            ',' +
            newCard.iconFour +
            ',' +
            newCard.iconFive +
            ',' +
            newCard.iconSix +
            ',' +
            newCard.iconSeven +
            ',' +
            newCard.iconEight +
            ',',
        currentPlayer.cardCount + 1,
        currentPlayer.stackCardsCount + 1);
    print(newCard.toJson().toString() + " asignada a " + newPlayer.nickname);
    await doc.reference.update(newPlayer.toJson());
  }
}
