import 'package:spot_it_game/domain/cards/card_model.dart';

abstract class ICardRepository {
  Future<Iterable<CardModel>> getDeck();
  //@brief set a new deck for roomID
  //@param roomID: Id of the room asking for a deck
  Future<void> createRoomDeck(String roomID);
}
