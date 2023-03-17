import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_dade_cho/utils/StorageManager.dart';
import 'package:path_provider/path_provider.dart';

import 'CardGame.dart';

class Deck {
  late final String theme;
  final allCardsList = [];
  final gameCardsQueue = Queue<CardGame>();
  final int size;

  Deck(this.size);


  Future<String> get _localPath async {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
  }

  Future<void> makeDeck() async {
    Map data = await StorageManager.readJson('assets/je_n_ai_jamais.json');

    data["game"].forEach((type, value) {
      var quantity = value["quantity"];
      for (var question in value["questions"]){
        allCardsList.add(CardGame(question, quantity));
      }
    });
    makeGameCardsQueue();
  }

  void makeGameCardsQueue(){
    var tmpCards = List.from(allCardsList);
    tmpCards.shuffle();
    for(var i = 0; i < size; i++ ){
      gameCardsQueue.add(tmpCards.removeLast());
    }
  }

  CardGame playCard(){
    return gameCardsQueue.removeFirst();
  }

  bool isEmpty(){
    return gameCardsQueue.isEmpty;
  }
}