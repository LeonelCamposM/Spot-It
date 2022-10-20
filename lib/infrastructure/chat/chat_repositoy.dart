import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spot_it_game/domain/chat/i_chat_repository.dart';
import 'package:spot_it_game/domain/chat/message.dart';

class ChatRepository implements IChatRepository {
  final CollectionReference<Message> _chatCollection;

  ChatRepository(FirebaseFirestore firestore)
      : _chatCollection = firestore
            .collection('/Room_Message/ jTKFlTMyk0Rw24pdPcmv/Chat')
            .withConverter<Message>(
              fromFirestore: (doc, options) => Message.fromJson(doc.data()!),
              toFirestore: (employee, options) => employee.toJson(),
            );

  @override
  Future<String> sendMessage(Message message, String roomID) async {
    final reference = await _chatCollection.add(message);
    return reference.id;
  }
}
