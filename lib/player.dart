class Player {
  int id;
  int _money;

  Player()
      : _money = 0,
        id = 0;

  int getMoney() {
    return _money;
  }

  void addMoney(int money) {
    if (money < 0) {
      // throw new IllegalArgumentException("Attempted robbery.");
      return;
    }
    _money += money;
  }
}


// roll
// build (houses)
// trade
// mortgage/unmortgaged
