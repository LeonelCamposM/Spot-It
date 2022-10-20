import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/chat/message.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';

class OnChatUpdate extends StatefulWidget {
  List<String> messages = [];

  @override
  _OnChatUpdateState createState() => _OnChatUpdateState();
}

class _OnChatUpdateState extends State<OnChatUpdate> {
  _OnChatUpdateState();

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection("/Room_Message/ jTKFlTMyk0Rw24pdPcmv/Chat")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        List<Message> messages = [];

        final list = ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                messages.add(Message(data['message'], data["time"]));
              })
              .toList()
              .cast(),
        );

        List<IconData> icons = [
          Icons.soap,
        ];

        messages.sort((a, b) => a.time.compareTo(b.time));
        List<String> sorted = [];
        for (var element in messages) {
          sorted.add(element.message);
        }
        return getVerticalList(sorted, icons);
      },
    );
  }
}
