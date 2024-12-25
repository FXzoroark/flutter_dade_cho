import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dade_cho/views/je_n_ai_jamais_game_screen.dart';
import 'package:flutter_dade_cho/widgets/settings_widget.dart';

import '../models/Player.dart';
import 'autobus_game_screen.dart';

class GameSelectionScreen extends StatefulWidget {
  final List<Player> players;

  const GameSelectionScreen({super.key, required this.players});

  @override
  State<GameSelectionScreen> createState() => _GameSelectionScreen();
}

class _GameSelectionScreen extends State<GameSelectionScreen> {
  late Map<String, Widget Function(BuildContext)> gamesMap;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    gamesMap = {
      "Je n'ai jamais": (context) =>
          JeNAiJamaisGameScreen(players: widget.players),
      "Autobus": (context) => AutobusGameScreen(players: widget.players)
    };
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Sélectionnez votre jeu",
                style: Theme.of(context).textTheme.headlineSmall),
            actions: const [SettingsWidget()]),
        body: Center(
            child: Column(
                children: gamesMap.keys.map((gameName) {
          return Card(
            color: Colors.amber,
            child: SizedBox(
                width: 300,
                height: 100,
                child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      final gameWidgetBuilder = gamesMap[gameName];
                      if (gameWidgetBuilder != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: gameWidgetBuilder));
                      }
                    },
                    child:
                    Text(gameName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall),
                    )),
          );
        }).toList())));
  }
}
