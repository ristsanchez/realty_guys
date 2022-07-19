import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/views/board_screen.dart';
import 'package:realty_guys/presentation/views/game_settings_screen.dart';
import 'package:realty_guys/presentation/views/host_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: const GameSettingsScreen(),
      ),
      // debugShowMaterialGrid: true,
      debugShowCheckedModeBanner: false,
      routes: {
        BoardScreen.routeName: (context) => const BoardScreen(),
      },
    );
  }
}
