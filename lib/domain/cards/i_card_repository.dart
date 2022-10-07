import 'package:spot_it_game/domain/cards/card_model.dart';

abstract class ICardRepository {
  Future<Iterable<CardModel>> getDeck();
}
