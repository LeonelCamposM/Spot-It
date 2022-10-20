import 'package:spot_it_game/domain/chat/i_chat_repository.dart';
import 'package:spot_it_game/domain/chat/message.dart';

class ChatUseCase {
  final IChatRepository chatRepository;
  ChatUseCase(this.chatRepository);

  Future<String> sendMessage(Message message, String roomID) {
    return chatRepository.sendMessage(message, roomID);
  }
}
