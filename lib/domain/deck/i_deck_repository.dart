import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/domain/deck/deck.dart';

abstract class IDeckRepository {
  Future<Iterable<CardModel>> getDeck();
}
