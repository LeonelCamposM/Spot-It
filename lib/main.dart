import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/cards/card_usage.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spot it',
        theme: ThemeData.dark(),
        routes: {
          WaitingRoomPage.routeName: (context) => const WaitingRoomPage(),
          HomePage.routeName: (context) => const HomePage(),
          CardUsage.routeName: (context) => const CardUsage()
        },
        initialRoute: HomePage.routeName);
  }
}
