import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'CardGame.dart';

class Deck {
  late final String theme;
  final allCardsList = [];
  final gameCardsQueue = Queue<CardGame>();
  final size;

  Deck(this.size);


  Future<String> get _localPath async {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
  }

  Future<void> makeDeck() async {

    readJson(await rootBundle.loadString('assets/je_n_ai_jamais.json'));
    makeGameCardsQueue();
  }

  void readJson(String jsonString){
    Map data = jsonDecode(jsonString);
    // theme = data["catégorie-nom-slogan"]["catégorie"] + ": " + data["catégorie-nom-slogan"]["nom"];
    // for (var difficulte in data["quizz"]["fr"]){
    //
    // }
    // queue.add(new Card())
    data["game"].forEach((type, value) {
      var quantity = value["quantity"];
      for (var question in value["questions"]){
        allCardsList.add(CardGame(question, quantity));
      }
    });

    // for(var type in data["game"]){
    //   var quantity = data["game"][type]["quantity"];
    //   for (var question in data["game"][type]["questions"]){
    //     allCardsList.add(CardGame(question, quantity));
    //   }
    // }
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
}