import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/color_constants.dart';

/// client join game settings
class IconSelectionProvider extends ChangeNotifier {
  final _colorList = AppColors.colorList;
  final _iconList = AppColors.iconList;
  int _colorIndex;
  int _iconIndex;

  //later name, text controller?
  IconSelectionProvider()
      : _colorIndex = 0,
        _iconIndex = 0;

  IconData get selectedIconData => _iconList.elementAt(_iconIndex);
  Color get selectedColor => _colorList.elementAt(_colorIndex);

  Icon get currentIcon => Icon(
        _iconList.elementAt(_iconIndex),
        color: _colorList.elementAt(_colorIndex),
        //07/17, not fine, this needs to be obtained from a constant file
        //depending on screen size
        size: 35,
      );

  void randomize() {
    _iconIndex = Random().nextInt(_iconList.length);
    _colorIndex = Random().nextInt(_colorList.length);
    notifyListeners();
  }

  void nextIcon() {
    _iconIndex++;
    if (_iconIndex >= _iconList.length) _iconIndex = 0;
    notifyListeners();
  }

  void previousIcon() {
    _iconIndex--;
    if (_iconIndex < 0) _iconIndex = _iconList.length - 1;
    notifyListeners();
  }

  void changeColor() {
    _colorIndex++;
    if (_colorIndex > _colorList.length - 1) _colorIndex = 0;
    notifyListeners();
  }
}
