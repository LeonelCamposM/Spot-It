import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

        List<String> messages = [];
        final list = ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                print(document.data());
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                messages.add(data['message']);
                return ListTile(
                  title: Text(data['message']),
                );
              })
              .toList()
              .cast(),
        );

        List<IconData> icons = [
          Icons.soap,
          Icons.nearby_error,
          Icons.join_left,
          Icons.leaderboard,
          Icons.soap,
          Icons.nearby_error,
          Icons.join_left,
          Icons.leaderboard
        ];

        return getVerticalList(messages, icons);
      },
    );
  }
}
