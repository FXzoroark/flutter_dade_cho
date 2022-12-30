import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class Player {
  String name;
  bool drinking = true;

  Player(this.name);

}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.close),
          const SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
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
                    _showToast("le nom d'un joueur non existant est requis");
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
                  color: Colors.amber,
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
                _showToast("Il faut être au moins 2 a jouer");
              }
              else {
                print("TODO");
              }
            },
            child: const Center(child: Icon(Icons.play_arrow))
        ),
      ),
    );
  }
}
