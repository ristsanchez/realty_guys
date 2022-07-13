import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realty_guys/color_constants.dart';
import 'package:realty_guys/json_util_data.dart';

class SelectionMenuProvider extends ChangeNotifier {
  final _colorList = colorList;
  final _iconList = iconList;
  int _colorIndex;
  int _index;

  SelectionMenuProvider()
      : _colorIndex = 0,
        _index = 0,
        _started = false,
        _data = HashMap();

  Icon get currentIcon => Icon(
        _iconList.elementAt(_index),
        size: 40, //change this
        color: _colorList.elementAt(_colorIndex),
      );

  void randomize() {
    _index = Random().nextInt(_iconList.length);
    _colorIndex = Random().nextInt(_colorList.length);
    notifyListeners();
  }

  void nextIcon() {
    _index++;
    if (_index >= _iconList.length) _index = 0;
    notifyListeners();
  }

  void previousIcon() {
    _index--;
    if (_index < 0) _index = _iconList.length - 1;
    notifyListeners();
  }

  void changeColor() {
    _colorIndex++;
    if (_colorIndex > _colorList.length - 1) _colorIndex = 0;
    notifyListeners();
  }
}
