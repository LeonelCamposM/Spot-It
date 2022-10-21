import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/chat/message.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

class OnChatUpdate extends StatefulWidget {
  const OnChatUpdate({Key? key}) : super(key: key);
  @override
  State<OnChatUpdate> createState() => _OnChatUpdateState();
}

// @brief eventListener waiting for changes on chat collection
// @return sorted by timestamp list of messages
class _OnChatUpdateState extends State<OnChatUpdate> {
  List<String> messages = [];
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection("/Room_Message/ jTKFlTMyk0Rw24pdPcmv/Chat")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: SizeConfig.blockSizeVertical * 85,
              width: SizeConfig.blockSizeHorizontal * 50,
              child: const Text(''));
        }

        List<Message> messages = getAllMessages(snapshot);
        return getVerticalList(messages);
      },
    );
  }
}

// @param snapshot: enventListener on database
// @return sorted by timestamp list of messages
List<Message> getAllMessages(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  // Get all chat messages from snapshot
  List<Message> messages = [];
  ListView(
    children: snapshot.data!.docs
        .map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          messages.add(Message(data['message'], data["time"], data["icon"]));
        })
        .toList()
        .cast(),
  );

  // Sort chat messages by timestamp
  messages.sort((a, b) => a.time.compareTo(b.time));
  List<Message> sorted = [];
  for (var element in messages.reversed) {
    sorted.add(element);
  }

  return sorted;
}
