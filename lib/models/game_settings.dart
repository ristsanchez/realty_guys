class GameSettings {
  final int houseLimit;

  int timeLimit; //seconds
  final int minTime, maxTime;

  int playerCount;
  final int minPlayers, maxPlayers;

  int money; //usd
  final int minMoney, maxMoney;

  bool collectIfJailed;
  bool auctionMode;

  GameSettings()
      : money = 1500,
        minMoney = 0,
        maxMoney = 7500,
        playerCount = 3,
        minPlayers = 2,
        maxPlayers = 7,
        houseLimit = 32,
        timeLimit = 30,
        minTime = 15,
        maxTime = 60,
        collectIfJailed = false,
        auctionMode = false;
  //    ^default settings
}
