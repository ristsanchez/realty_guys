import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/board_screen.dart';
import 'package:realty_guys/board_ui_provider.dart';

class SetGameScreen extends StatelessWidget {
  const SetGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //call new route/ replace
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((BuildContext context) =>
                        MultiProvider(providers: [
                          ChangeNotifierProvider(
                              create: (_) => BoardProvider()),
                        ], child: const BoardScreen()))));
          },
          child: const Text('Go?'),
        ),
      ),
    );
  }
}
