import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/cards/deck_use_case.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/infrastructure/cards/card_repository.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';

class CardUsage extends StatefulWidget {
  static String routeName = '/card_usage';
  const CardUsage({Key? key}) : super(key: key);

  @override
  State<CardUsage> createState() => _CardUsageState();
}

class _CardUsageState extends State<CardUsage> {
  _CardUsageState() : isLoading = true;
  CardUseCase cardUseCase =
      CardUseCase(CardRepository(FirebaseFirestore.instance));
  Iterable<CardModel> deckData = [];

  bool isLoading;

  @override
  void initState() {
    super.initState();
    addRoom();
  }

  Future<void> addRoom() async {
    final deck = await cardUseCase.getDeck();
    setState(() {
      deckData = deck;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Guia cartas'),
          backgroundColor: const Color.fromARGB(255, 60, 60, 60)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child:
              isLoading ? const LoadingWidget() : _RoomWidget(deck: deckData),
        ),
      ),
    );
  }
}

class _RoomWidget extends StatefulWidget {
  final Iterable<CardModel> deck;
  _RoomWidget({Key? key, required this.deck}) : super(key: key);

  @override
  State<_RoomWidget> createState() => _RoomWidgetState(deck);
}

class _RoomWidgetState extends State<_RoomWidget> {
  final Iterable<CardModel> deck;
  _RoomWidgetState(this.deck);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getCardStyle(deck.elementAt(0), 300),
              getCardStyle(deck.elementAt(0), 200),
              getCardStyle(deck.elementAt(0), 100),
              getCardStyle(deck.elementAt(0), 200),
              getCardStyle(deck.elementAt(0), 200),
              getCardStyle(deck.elementAt(0), 200),
            ],
          ),
        ),
      ],
    );
  }
}
