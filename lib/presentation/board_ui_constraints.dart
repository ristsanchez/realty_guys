import 'package:flutter/material.dart';

class BoardConstraints {
  static BoxConstraints cardConstraints(double maxWidth) {
    //size is the middle 5/7 minus the side paddings 10+10 minus inner padding 20
    // 7 [1side + 5center + 1side] board flex values
    double maxSideSize = ((maxWidth - 20) * 5 / 7) - 20;
    return BoxConstraints(
      maxHeight: maxSideSize,
      maxWidth: maxSideSize,
    );
  }

  static BoxConstraints slimCardConstraints(double maxWidth) {
    //size is the middle 5/7 minus the side paddings 10+10 minus inner padding 20
    // 7 [1side + 5center + 1side] board flex values
    double maxSideSize = ((maxWidth - 20) * 5 / 7) - 20;
    return BoxConstraints(
      maxHeight: maxSideSize * 9 / 16,
      maxWidth: maxSideSize,
    );
  }

// linear progess indicator thickness + button with padding
  static const double topRowPadding = 4 + 8 + 40 + 8;
}
