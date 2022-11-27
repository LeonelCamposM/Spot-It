import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';

// ignore: must_be_immutable
class OnRoundUpdate extends StatelessWidget {
  String roomID;
  late Stream<QuerySnapshot> _usersStream;
  bool isHost;
  OnRoundUpdate({Key? key, required this.isHost, required this.roomID})
      : super(key: key) {
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

        // Trigger
        Room room = getUpdateRoom(snapshot, roomID);
        if (isHost) {
          if (room.newRound == true && !room.finished) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await dealCards(roomID);
            });
          }
        }
        if (room.round > room.maximumRounds) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await sendEndGame(roomID);
          });
        }
        room.round + 1;
        return getText("Ronda: " + room.round.toString(),
            SizeConfig.blockSizeHorizontal * 1.2, Alignment.topCenter);
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
  var roomReference = FirebaseFirestore.instance.collection('Room').doc(roomID);
  var roomquery = await roomReference.get();
  Map<String, dynamic> data = roomquery.data()!;

  if (data["round"] == 0) {
  } else {
    final newRoom = Room(data["round"], data["joinable"], true, false,
        data["finished"], data["updatedRound"], data["maximumRounds"]);
    roomReference.update(newRoom.toJson());
    // Get players collection
    var collection = FirebaseFirestore.instance
        .collection('Room_Player')
        .doc(roomID)
        .collection('players');
    var snapshots = await collection.get();

    List<String> fullDeck = [
      'Anchor,Apple,Bomb,Cactus,Candle,Carrot,Cheese,Chessknight',
      'Anchor,Clock,Clown,Diasyflower,Dinosaur,Dolphin,Dragon,Exclamationmark',
      'Anchor,Eye,Fire,Fourleafclover,Ghost,Greensplats,Hammer,Heart',
      'Anchor,IceCube,Igloo,Key,Ladybird,LightBulb,LightningBolt,Lock',
      'Anchor,MapleLeaf,MilkBottle,Moon,NoEntrySign,ScarecrowMan,Pencil,PurpleBird',
      'Anchor,PurpleCat,logo,QuestionMark,Redlips,Scissors,SkullAndCrossbones,Snowflake',
      'Anchor,Snowman,Spider,Spidersweb,Sun,Sunglasses,Target,Taxi',
      'Anchor,Tortoise,Trebleclef,Tree,Waterdrop,Dog,Yinandyang,Zebra',
      'Apple,Clock,Eye,IceCube,MapleLeaf,PurpleCat,Snowman,Tortoise',
      'Apple,Clown,Fire,Igloo,MilkBottle,logo,Spider,Trebleclef',
      'Apple,Diasyflower,Fourleafclover,Key,Moon,QuestionMark,Spidersweb,Tree',
      'Apple,Dinosaur,Ghost,Ladybird,NoEntrySign,Redlips,Sun,Waterdrop',
      'Apple,Dolphin,Greensplats,LightBulb,ScarecrowMan,Scissors,Sunglasses,Dog',
      'Apple,Dragon,Hammer,LightningBolt,Pencil,SkullAndCrossbones,Target,Yinandyang',
      'Apple,Exclamationmark,Heart,Lock,PurpleBird,Snowflake,Taxi,Zebra',
      'Bomb,Clock,Fire,Key,NoEntrySign,Scissors,Target,Zebra',
      'Bomb,Clown,Fourleafclover,Ladybird,ScarecrowMan,SkullAndCrossbones,Taxi,Tortoise',
      'Bomb,Diasyflower,Ghost,LightBulb,Pencil,Snowflake,Snowman,Trebleclef',
      'Bomb,Dinosaur,Greensplats,LightningBolt,PurpleBird,PurpleCat,Spider,Tree',
      'Bomb,Dolphin,Hammer,Lock,MapleLeaf,logo,Spidersweb,Waterdrop',
      'Bomb,Dragon,Heart,IceCube,MilkBottle,QuestionMark,Sun,Dog',
      'Bomb,Exclamationmark,Eye,Igloo,Moon,Redlips,Sunglasses,Yinandyang',
      'Cactus,Clock,Fourleafclover,LightBulb,PurpleBird,logo,Sun,Yinandyang',
      'Cactus,Clown,Ghost,LightningBolt,MapleLeaf,QuestionMark,Sunglasses,Zebra',
      'Cactus,Diasyflower,Greensplats,Lock,MilkBottle,Redlips,Target,Tortoise',
      'Cactus,Dinosaur,Hammer,IceCube,Moon,Scissors,Taxi,Trebleclef',
      'Cactus,Dolphin,Heart,Igloo,NoEntrySign,SkullAndCrossbones,Snowman,Tree',
      'Cactus,Dragon,Eye,Key,ScarecrowMan,Snowflake,Spider,Waterdrop',
      'Cactus,Exclamationmark,Fire,Ladybird,Pencil,PurpleCat,Spidersweb,Dog',
      'Candle,Clock,Ghost,Lock,Moon,SkullAndCrossbones,Spider,Dog',
      'Candle,Clown,Greensplats,IceCube,NoEntrySign,Snowflake,Spidersweb,Yinandyang',
      'Candle,Diasyflower,Hammer,Igloo,ScarecrowMan,PurpleCat,Sun,Zebra',
      'Candle,Dinosaur,Heart,Key,Pencil,logo,Sunglasses,Tortoise',
      'Candle,Dolphin,Eye,Ladybird,PurpleBird,QuestionMark,Target,Trebleclef',
      'Candle,Dragon,Fire,LightBulb,MapleLeaf,Redlips,Taxi,Tree',
      'Candle,Exclamationmark,Fourleafclover,LightningBolt,MilkBottle,Scissors,Snowman,Waterdrop',
      'Carrot,Clock,Greensplats,Igloo,Pencil,QuestionMark,Taxi,Waterdrop',
      'Carrot,Clown,Hammer,Key,PurpleBird,Redlips,Snowman,Dog',
      'Carrot,Diasyflower,Heart,Ladybird,MapleLeaf,Scissors,Spider,Yinandyang',
      'Carrot,Dinosaur,Eye,LightBulb,MilkBottle,SkullAndCrossbones,Spidersweb,Zebra',
      'Carrot,Dolphin,Fire,LightningBolt,Moon,Snowflake,Sun,Tortoise',
      'Carrot,Dragon,Fourleafclover,Lock,NoEntrySign,PurpleCat,Sunglasses,Trebleclef',
      'Carrot,Exclamationmark,Ghost,IceCube,ScarecrowMan,logo,Target,Tree',
      'Cheese,Clock,Hammer,Ladybird,MilkBottle,Snowflake,Sunglasses,Tree',
      'Cheese,Clown,Heart,LightBulb,Moon,PurpleCat,Target,Waterdrop',
      'Cheese,Diasyflower,Eye,LightningBolt,NoEntrySign,logo,Taxi,Dog',
      'Cheese,Dinosaur,Fire,Lock,ScarecrowMan,QuestionMark,Snowman,Yinandyang',
      'Cheese,Dolphin,Fourleafclover,IceCube,Pencil,Redlips,Spider,Zebra',
      'Cheese,Dragon,Ghost,Igloo,PurpleBird,Scissors,Spidersweb,Tortoise',
      'Cheese,Exclamationmark,Greensplats,Key,MapleLeaf,SkullAndCrossbones,Sun,Trebleclef',
      'Chessknight,Clock,Heart,LightningBolt,ScarecrowMan,Redlips,Spidersweb,Trebleclef',
      'Chessknight,Clown,Eye,Lock,Pencil,Scissors,Sun,Tree',
      'Chessknight,Diasyflower,Fire,IceCube,PurpleBird,SkullAndCrossbones,Sunglasses,Waterdrop',
      'Chessknight,Dinosaur,Fourleafclover,Igloo,MapleLeaf,Snowflake,Target,Dog',
      'Chessknight,Dolphin,Ghost,Key,MilkBottle,PurpleCat,Taxi,Yinandyang',
      'Chessknight,Dragon,Greensplats,Ladybird,Moon,logo,Snowman,Zebra',
      'Chessknight,Exclamationmark,Hammer,LightBulb,NoEntrySign,QuestionMark,Spider,Tortoise'
    ];

    // get random cards from deck
    fullDeck.shuffle();
    Iterable<String> cards = fullDeck.take(snapshots.docs.length);

    int counter = 0;
    for (var doc in snapshots.docs) {
      // Get current player
      final query = await doc.reference.get();
      Map<String, dynamic> data = query.data()!;
      final currentPlayer = Player(data['nickname'], data["icon"],
          data["displayedCard"], data["cardCount"], data["stackCardsCount"]);

      // Give card to user
      String newCard = cards.elementAt(counter);
      counter += 1;

      // Update new player card
      Player newPlayer =
          Player(currentPlayer.nickname, currentPlayer.icon, newCard, 1, 1);
      await doc.reference.update(newPlayer.toJson());
    }
  }
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
