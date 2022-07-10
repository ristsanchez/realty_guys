import 'dart:math';

class Die {
  final Random _randomGenerator;

  Die() : _randomGenerator = Random();

  int roll() {
    return _randomGenerator.nextInt(6) + 1;
  }
}
