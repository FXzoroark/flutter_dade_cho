import 'package:flutter/material.dart';
import 'package:flutter_dade_cho/player_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Select Screen',
      home: PlayerSelectionScreen(),
    );
  }
}
