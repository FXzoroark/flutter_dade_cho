import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_dade_cho/models/Player.dart';
import 'package:flutter_dade_cho/utils/toast.dart';
import 'package:flutter_dade_cho/views/game_selection_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PlayerSelectionScreen extends StatefulWidget {
  const PlayerSelectionScreen({super.key});

  @override
  State<PlayerSelectionScreen> createState() => _PlayerSelectionScreen();
}

class _PlayerSelectionScreen extends State<PlayerSelectionScreen> {
  List<Player> players = [];


  final textController = TextEditingController();
  int? playerIndex;
  IconData buttonIcon = Icons.add;

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(String text) {
    fToast.showToast(
      child: ToastWrapper(
        icon: Icons.close ,
        color:Colors.redAccent.withOpacity(0.8),
        msg:text,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }

  _removeAllQueuedToasts() {
    fToast.removeQueuedCustomToasts();
  }

  Widget _cardItem(index) {
    return Card(
        child: ListTile(
          title: Text(players[index].name),
          trailing: Checkbox(
            value: players[index].drinking,
            onChanged: (bool? value) {
              setState(() {
                players[index].drinking = value!;
              });
            },
          ),
          onTap: () {
            playerIndex = index;
            setState(() {
              textController.text = players[index].name;
              buttonIcon = Icons.save;
            });
          },
          onLongPress: () {
            playerIndex = null;
            buttonIcon = Icons.add;
            setState(() {
              players.removeAt(index);
            });
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: TextField(
                  controller: textController,
                )
            ),
            ElevatedButton(
                child: Icon(buttonIcon),
                onPressed: () {
                  if (textController.text.isEmpty ||
                      players.firstWhereOrNull((element) => element.name ==
                          textController.text) != null) {
                    _removeAllQueuedToasts();
                    _showToast("Le nom d'un joueur non existant est requis");
                  }
                  else {
                    setState(() {
                      if (playerIndex != null) {
                        players[playerIndex!].name = textController.text;
                        playerIndex = null;
                        buttonIcon = Icons.add;
                      }
                      else {
                        players.add(Player(textController.text));
                      }
                      textController.clear();
                    });
                  }
                }
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [
                Container(
                  color: Colors.grey,
                  child: const ListTile(
                    title: Text("Name"),
                    trailing: Text("Drinking"),
                  ),
                ),
                _cardItem(index)
              ],
            );
          }
          return _cardItem(index);
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.purple,
        child: InkWell(
            onTap: () {
              if (players.length < 2) {
                _removeAllQueuedToasts();
                _showToast("Il faut être au moins 2 pour jouer");
              }
              else {
                _removeAllQueuedToasts();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameSelectionScreen(players: players)),
                );
              }
            },
            child: const Center(child: Icon(Icons.play_arrow))
        ),
      ),
    );
  }
}