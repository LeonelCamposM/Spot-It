import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/domain/sockets/socketServices.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/game/game.dart';

class OnJoinableUpdate extends StatefulWidget {
  var context;

  OnJoinableUpdate({required BuildContext this.context});
  @override
  State<OnJoinableUpdate> createState() => _OnJoinableUpdateState(context);
}

// @brief eventListener waiting for changes on chat collection
// @return sorted by timestamp list of messages
class _OnJoinableUpdateState extends State<OnJoinableUpdate> {
  final SocketService socketService = SocketService();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection("/Room").snapshots();

  _OnJoinableUpdateState(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('waiting');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['joinable'] == true) {
                  // Navigator.pushNamed(context, GamePage.routeName);
                  socketService.sendOnJoinableUpdate("");
                }
                return ListTile(
                  title: Text(data['joinable'].toString()),
                  subtitle: Text(data['round'].toString()),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}
