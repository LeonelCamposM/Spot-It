import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/domain/cards/i_card_repository.dart';

class CardRepository implements ICardRepository {
  final CollectionReference<CardModel> _deckCollection;

  CardRepository(FirebaseFirestore firestore)
      : _deckCollection = firestore.collection('Deck').withConverter<CardModel>(
              fromFirestore: (doc, options) => CardModel.fromJson(doc.data()!),
              toFirestore: (cardModel, options) => cardModel.toJson(),
            );

  @override
  Future<Iterable<CardModel>> getDeck() async {
    final result = await _deckCollection.get();
    return result.docs.map((snapshot) => snapshot.data());
  }
}
