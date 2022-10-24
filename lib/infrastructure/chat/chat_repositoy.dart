import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/chat/i_chat_repository.dart';
import 'package:spot_it_game/domain/chat/message.dart';
import 'package:spot_it_game/infrastructure/chat/eventListeners/on_chat_update.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

class ChatRepository implements IChatRepository {
  late final CollectionReference<Message> _chatCollection;
  late final FirebaseFirestore db;
  late String roomID;
  ChatRepository(FirebaseFirestore firestore, String roomID) {
    _chatCollection = firestore
        .collection('/Room_Message/' + roomID + '/Chat')
        .withConverter<Message>(
          fromFirestore: (doc, options) => Message.fromJson(doc.data()!),
          toFirestore: (object, options) => object.toJson(),
        );
    db = firestore;
  }

  @override
  Future<String> sendMessage(Message message) async {
    _chatCollection.add(message);
    return "";
  }

  @override
  Widget onChatUpdate() {
    return const OnChatUpdate();
  }
}
