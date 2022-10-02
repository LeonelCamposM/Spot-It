import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/rooms/create_room.dart';
import 'package:flutter/services.dart';

class WaitingRoomPage extends StatefulWidget {
  static String routeName = '/waiting_room';
  const WaitingRoomPage({Key? key}) : super(key: key);
  @override
  State<WaitingRoomPage> createState() => _WaitingRoomPageState();
}

class _WaitingRoomPageState extends State<WaitingRoomPage> {
  _WaitingRoomPageState() : isLoading = true;
  bool isLoading;
  List<String> names = ["Sofia", "Nayeri", "Jeremy", "Leonel"];
  String roomID = "gMIPh2BsGpaZqIx6EHPj";

  @override
  void initState() {
    super.initState();
    addRoom();
  }

  Future<void> addRoom() async {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sala de espera'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 30.0,
                    icon: const Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoomPage()),
                      );
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    icon: const Icon(Icons.chat),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoomPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 30.0,
                    icon: const Icon(Icons.content_copy),
                    color: Colors.white,
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: roomID));
                    },
                  ),
                  Text(roomID, style: new TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            Text("", style: new TextStyle(fontSize: 40.0)),
            Flexible(
              flex: 4,
              child:
                  SizedBox(height: 150, width: 850, child: _horizontalList(4)),
            ),
            Flexible(
                flex: 4,
                child: SizedBox(
                    height: 150, width: 850, child: _horizontalList(4))),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 50.0,
                    icon: const Icon(Icons.play_circle),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoomPage()),
                      );
                    },
                  ),
                  const Text("Comenzar", style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container _horizontalList(int n) {
  return Container(
    alignment: Alignment.center,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        n,
        (i) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.amber, shape: BoxShape.circle),
                  child: Icon(Icons.person)),
              Text("Participantes", style: new TextStyle(fontSize: 20.0))
            ]),
          ),
        ),
      ),
    ),
  );
}
