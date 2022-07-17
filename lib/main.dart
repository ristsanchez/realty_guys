import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/presentation/board_screen.dart';
import 'package:realty_guys/providers/game_settings_provider.dart';
import 'package:realty_guys/presentation/game_settings_screen.dart';

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
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => GameSettings(),
            ),
          ],
          child: const GameSettingsScreen(),
        ),
      ),
      // debugShowMaterialGrid: true,
      debugShowCheckedModeBanner: false,
      routes: {
        BoardScreen.routeName: (context) => BoardScreen(
              propertyData: HashMap(),
            ),
      },
    );
  }
}
