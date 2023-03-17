import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter_dade_cho/models/CardGame.dart';
import 'package:flutter_dade_cho/models/Deck.dart';

import 'package:flutter_dade_cho/models/Player.dart';
import 'package:flutter_dade_cho/views/player_selection_screen.dart';
import 'package:flutter_dade_cho/widgets/settings_widget.dart';

class GameScreen extends StatefulWidget {
  final List<Player> players;

  const GameScreen({Key? key, required this.players}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {
  late Deck deck = Deck(50);
  late CardGame currentCard;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    BackButtonInterceptor.add(myInterceptor, name: "toto", context: context);
    _asyncMethods();
  }

  void _asyncMethods() async {
    await deck.makeDeck();
    currentCard = deck.playCard();
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print(stopDefaultButtonEvent);
    //BackButtonInterceptor.;
    if (stopDefaultButtonEvent) return false;
    if (info.ifRouteChanged(context)) return true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const CircularProgressIndicator();

    return Scaffold(
        appBar: AppBar(
            title: Column(
          children: [
            Text("${deck.size - deck.gameCardsQueue.length} /  ${deck.size}"),
            Text("${currentCard.quantity} 🍺")
          ],
        ),
            actions: const [
              SettingsWidget()
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                if(deck.isEmpty()){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PlayerSelectionScreen()),
                  );
                  return;
                }
                currentCard = deck.playCard();
              });
            },
            child: Container(
                //color: const Color(0xff1E88E5),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                child: Text.rich(WidgetSpan(
                    child: Text(currentCard.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1))))));
  }
}
