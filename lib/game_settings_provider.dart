import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realty_guys/color_constants.dart';
import 'package:realty_guys/json_util_data.dart';

class GameSettings extends ChangeNotifier {
  final _colorList = colorList;
  final _iconList = iconList;
  int _colorIndex;
  int _index;

  bool _started;
  late HashMap<int, dynamic> _data;

  GameSettings()
      : _colorIndex = 0,
        _index = 0,
        _started = false,
        _data = HashMap();

  bool get isInit => _started;

  HashMap<int, dynamic> get data => _data;

  Icon get currentIcon => Icon(
        _iconList.elementAt(_index),
        size: 40, //change this
        color: _colorList.elementAt(_colorIndex),
      );

  IconData get selectedIconData => _iconList.elementAt(_index);
  Color get selectedColor => _colorList.elementAt(_colorIndex);

  void init() async {
    _data = await getPropertyData();
    await Future.delayed(const Duration(milliseconds: 500));
    _started = true;
    notifyListeners();
  }

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
