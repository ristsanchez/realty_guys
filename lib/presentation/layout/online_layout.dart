import 'package:flutter/material.dart';

class ClientHostLayout extends StatelessWidget {
  const ClientHostLayout({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    List<Widget> temp = [];
    for (var each in children) {
      temp.insert(
          temp.length,
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5), child: each));
    }

    temp.insert(0, const SizedBox(height: 10));

    return ScrollConfiguration(
      behavior: _MyBehavior(),
      child: ListView(
        children: temp,
      ),
    );
  }
}

class _MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
