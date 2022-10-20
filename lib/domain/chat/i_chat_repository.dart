import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/chat/message.dart';

abstract class IChatRepository {
  Future<String> sendMessage(Message message, String roomID);
  Widget onChatUpdate();
}
