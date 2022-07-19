import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/views/board_view_final.dart';

//to be the layout later on
class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);
  static const routeName = '/boardScreen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: const BoardLayout(),
        ));
  }
}
