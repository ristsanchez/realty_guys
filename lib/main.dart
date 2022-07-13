import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/board_screen.dart';
import 'package:realty_guys/selection_provider.dart';
import 'package:realty_guys/set_game_screen.dart';

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
              create: (_) => SelectionMenuProvider(),
            ),
          ],
          child: const SetGameScreen(),
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
