import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

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
        if (isHost) {
          if (!room.dealedCards && !room.finished) {
            dealCards(roomID);
          } else {
            if (room.newRound == true && !room.finished) {
              dealCards(roomID);
            }
          }
        }
        if (room.round > room.maximumRounds) {
          sendEndGame(roomID);
        }
        return const Text('');
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
            messages.add(Room.fromJson(data));
          }
        })
        .toList()
        .cast(),
  );

  return messages.first;
}

Future<void> dealCards(String roomID) async {
  // Get players collection
  var collection = FirebaseFirestore.instance
      .collection('Room_Player')
      .doc(roomID)
      .collection('players');
  var snapshots = await collection.get();

  // Get deck collection
  final roomDeckReference = FirebaseFirestore.instance.collection('Deck');

  // Get new cards
  final newCardsReference = await roomDeckReference.get();
  List<CardModel> fullDeck = newCardsReference.docs
      .map((snapshot) => CardModel.fromJson(snapshot.data()))
      .toList();

  // get random cards from deck
  fullDeck.shuffle();
  Iterable<CardModel> cards = fullDeck.take(snapshots.docs.length);

  int counter = 0;
  for (var doc in snapshots.docs) {
    // Get current player
    final query = await doc.reference.get();
    Map<String, dynamic> data = query.data()!;
    final currentPlayer = Player(data['nickname'], data["icon"],
        data["displayedCard"], data["cardCount"], data["stackCardsCount"]);

    // Give card to user
    CardModel newCard = cards.elementAt(counter);
    counter += 1;

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
        1,
        1);
    await doc.reference.update(newPlayer.toJson());
  }

  // Get players collection
  var roomReference = FirebaseFirestore.instance.collection('Room').doc(roomID);
  var roomquery = await roomReference.get();
  Map<String, dynamic> data = roomquery.data()!;
  final newRoom = Room(data["round"], data["joinable"], true, false,
      data["finished"], data["updatedRound"], data["maximumRounds"]);
  roomReference.update(newRoom.toJson());
}

Future<void> sendEndGame(String roomID) async {
  var roomRefrence = FirebaseFirestore.instance.collection('Room').doc(roomID);
  var rooms = await roomRefrence.get();
  Room newRoom = Room.fromJson(rooms.data()!);
  newRoom.finished = true;
  roomRefrence.update(newRoom.toJson());
  // Get players collection
  var collection = FirebaseFirestore.instance
      .collection('Room_Player')
      .doc(roomID)
      .collection('players');
  var snapshots = await collection.get();

  for (var doc in snapshots.docs) {
    // Get current player
    final query = await doc.reference.get();
    Map<String, dynamic> data = query.data()!;
    final currentPlayer = Player(data['nickname'], data["icon"],
        data["displayedCard"], data["cardCount"], data["stackCardsCount"]);

    // Update new player card
    Player newPlayer = Player(currentPlayer.nickname, currentPlayer.icon,
        currentPlayer.displayedCard, -1, currentPlayer.stackCardsCount);
    await doc.reference.update(newPlayer.toJson());
  }
}
