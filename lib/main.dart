import 'package:flutter/material.dart';
import 'package:flutter_dade_cho/utils/ThemeManager.dart';
import 'package:flutter_dade_cho/views/player_selection_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          title: 'Select Screen',
          theme: theme.getTheme(),
          debugShowCheckedModeBanner: false,
          home: const PlayerSelectionScreen(),
        )
      )
    );

  }
}
