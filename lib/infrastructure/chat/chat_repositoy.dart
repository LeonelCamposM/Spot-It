import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spot_it_game/domain/chat/i_chat_repository.dart';
import 'package:spot_it_game/domain/chat/message.dart';

class ChatRepository implements IChatRepository {
  late final CollectionReference<Message> _chatCollection;
  late final FirebaseFirestore db;
  ChatRepository(FirebaseFirestore firestore) {
    _chatCollection = firestore
        .collection('/Room_Message/ jTKFlTMyk0Rw24pdPcmv/Chat')
        .withConverter<Message>(
          fromFirestore: (doc, options) => Message.fromJson(doc.data()!),
          toFirestore: (employee, options) => employee.toJson(),
        );
    db = firestore;
  }

  // @override
  // Future<String> sendMessage(Message message, String roomID) async {
  //   db.runTransaction((transaction) async {
  //     var newRef = _chatCollection.doc();
  //     transaction.set(newRef, message.toJson());
  //   }).then(
  //     // ignore: avoid_print
  //     (value) => print("DocumentSnapshot successfully updated!"),
  //     // ignore: avoid_print
  //     onError: (e) => print("Error updating document $e"),
  //   );
  //   return "";
  // }

  @override
  Future<String> sendMessage(Message message, String roomID) async {
    _chatCollection.add(message);
    return "";
  }
}
