import 'package:spot_it_game/domain/deck/deck.dart';
import 'package:spot_it_game/domain/deck/i_deck_repository.dart';

import '../../domain/cards/card_model.dart';

class DeckUseCase {
  final IDeckRepository deckRepository;

  DeckUseCase(this.deckRepository);

  Future<Iterable<CardModel>> getDeck() {
    return deckRepository.getDeck();
  }
}
