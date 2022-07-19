import 'dart:math';

class Die {
  final Random _randomGenerator;

  Die() : _randomGenerator = Random();

  ///[die] behavior, get random int from (1 to 6)
  int get roll => _randomGenerator.nextInt(6) + 1;
}
