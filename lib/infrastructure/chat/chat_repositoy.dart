import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/chat/i_chat_repository.dart';
import 'package:spot_it_game/domain/chat/message.dart';
import 'package:spot_it_game/infrastructure/chat/eventListeners/on_chat_update.dart';

class ChatRepository implements IChatRepository {
  late final CollectionReference<Message> _chatCollection;
  late final FirebaseFirestore db;
  ChatRepository(FirebaseFirestore firestore) {
    _chatCollection = firestore
        .collection('/Room_Message/ jTKFlTMyk0Rw24pdPcmv/Chat')
        .withConverter<Message>(
          fromFirestore: (doc, options) => Message.fromJson(doc.data()!),
          toFirestore: (object, options) => object.toJson(),
        );
    db = firestore;
  }

  @override
  Future<String> sendMessage(Message message, String roomID) async {
    _chatCollection.add(message);
    return "";
  }

  @override
  Widget onChatUpdate() {
    return OnChatUpdate();
  }
}
