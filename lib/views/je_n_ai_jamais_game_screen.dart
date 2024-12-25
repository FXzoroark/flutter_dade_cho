import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dade_cho/models/CardGame.dart';
import 'package:flutter_dade_cho/models/Deck.dart';

import 'package:flutter_dade_cho/models/Player.dart';
import 'package:flutter_dade_cho/widgets/settings_widget.dart';

class JeNAiJamaisGameScreen extends StatefulWidget {
  final List<Player> players;

  const JeNAiJamaisGameScreen({super.key, required this.players});

  @override
  State<JeNAiJamaisGameScreen> createState() => _JeNAiJamaisGameScreen();
}

class _JeNAiJamaisGameScreen extends State<JeNAiJamaisGameScreen> {
  late Deck deck = Deck(50);
  late CardGame currentCard;

  bool loading = true;

  @override
  void initState() {
    super.initState();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const CircularProgressIndicator();

    return Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("${deck.size - deck.gameCardsQueue.length} /  ${deck.size}"),
                    Text("${currentCard.quantity} 🍺"),
                  ],
                ),
                Text(currentCard.type)
              ],
            ),
            actions: const [
              SettingsWidget()
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState( () {
              if (deck.isEmpty()) {
                Navigator.of(context).pop();
              } else {
                currentCard = deck.playCard();
              }
            });
          },
          child: Container(
              //color: const Color(0xff1E88E5),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20.0),
              child: Text.rich(WidgetSpan(
                  child: Text(currentCard.label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall))))));
  }
}
