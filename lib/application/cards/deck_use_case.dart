import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/domain/cards/i_card_repository.dart';

class CardUseCase {
  final ICardRepository cardRepository;

  CardUseCase(this.cardRepository);

  Future<Iterable<CardModel>> getDeck() {
    return cardRepository.getDeck();
  }
}
