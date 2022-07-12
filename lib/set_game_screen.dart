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
    );
  }
}
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        //call new route/ replace
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((BuildContext context) => MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                      create: (_) => BoardUIProvider(),
                                    ),
                                    ChangeNotifierProvider(
                                      create: (_) => Board(),
                                    )
                                  ],
                                  child: const BoardScreen(),
                                )),
                          ),
                        );
                      },
                      child: const Text('Go?'),
                    ),
                  ),
                ),
