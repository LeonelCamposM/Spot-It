import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/chat/message.dart';

abstract class IChatRepository {
  // @param message: message to send
  // @param roomID: id of the destiny room
  Future<String> sendMessage(Message message, String roomID);

  // @brief: enventListener waiting for changes on chat
  // @return Widget: vertical list with all chat messages in order
  Widget onChatUpdate();
}
