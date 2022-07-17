import 'package:flutter/material.dart';

getInnerRing(int position, int rotations) {
  if (position < 0) {
    return const Center();
  }
  //where N:0, E:1, S:2, W:3
  int orientation = position ~/ 10;

  int initialPosition = position % 10;
  // <= 8 full, 9 corner and right, LEADING
  // 9 full, 8 right and corner, TRAILING

  int leadingOffset = initialPosition;
  int leadingWeight = 9 - initialPosition;

  int trailingWeight = initialPosition > 7 ? 8 : initialPosition + 1;
  int trailingOffset = initialPosition > 6 ? 0 : 7 - initialPosition;

  List<Widget> temp = [];
  List<Widget> temp2 = [];

  for (var i = 0; i < leadingWeight; i++) {
    temp.insert(
        i,
        Expanded(
            flex: 1,
            child: Center(
                child: RotatedBox(
                    quarterTurns: -rotations - orientation,
                    child: Text('${i + 1}')))));
  }
  temp.insert(0, Expanded(flex: leadingOffset, child: const Center()));

  for (var i = 0; i < trailingWeight; i++) {
    temp2.insert(
        i,
        Expanded(
            flex: 1,
            child: Center(
                child: RotatedBox(
                    quarterTurns: -rotations - orientation,
                    child: Text('${i + leadingWeight + 3}')))));
  }
  temp2.insert(
      temp2.length, Expanded(flex: trailingOffset, child: const Center()));
  //cuttoff should be 11-offset the rest to the column
  var leadingRow = Row();
  var leadingCol = Column();

  return RotatedBox(
    quarterTurns: orientation,
    child: Column(
      children: [
        Expanded(flex: 1, child: Row(children: temp)),
        Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(flex: 8, child: Center()),
                Expanded(
                    child: Column(
                  children: temp2,
                ))
              ],
            )),
      ],
    ),
  );
}
