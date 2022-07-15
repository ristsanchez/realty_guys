import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realty_guys/color_constants.dart';
import 'package:realty_guys/json_util_data.dart';
import 'package:realty_guys/luck_card.dart';
import 'package:realty_guys/timer_local.dart';

class GameSettings extends ChangeNotifier {
  final _colorList = colorList;
  final _iconList = iconList;
  int _colorIndex;
  int _index;

  bool _isDataReady;
  late List<LuckCard> _chanceCards;
  late List<LuckCard> _luckyCards;

  late HashMap<int, dynamic> _tileData;

  GameSettings()
      : _colorIndex = 0,
        _index = 0,
        _isDataReady = false,
        _tileData = HashMap(),
        _chanceCards = [],
        _luckyCards = [];

  bool get isInit => _isDataReady;

  List<LuckCard> get chanceCards => _chanceCards;

  List<LuckCard> get luckyCards => _chanceCards;

  HashMap<int, dynamic> get tileData => _tileData;

  IconData get selectedIconData => _iconList.elementAt(_index);
  Color get selectedColor => _colorList.elementAt(_colorIndex);

  Icon get currentIcon => Icon(
        _iconList.elementAt(_index),

        //This is fine, maybe because its just for display, not for actual game
        size: 40,
        color: _colorList.elementAt(_colorIndex),
      );

  void init() async {
    _tileData = await getPropertyData();
    _chanceCards = await getLuckyCardsData('chance');
    _luckyCards = await getLuckyCardsData('lucky');
    await Future.delayed(const Duration(milliseconds: 250));

    _isDataReady = true;
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
