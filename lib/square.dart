class Square {
  Square(
    this.name,
    this.boardSpace,
    this.group,
  );

  String name;
  int boardSpace; //id
  String group;
class Property {
  final int _id;
  final int _cost;
  final String _name;
  final String _group;

  late Player _owner; //id from player object
  bool _hasOwner = false;
  bool _isMortgaged = false;

  Property(
    this._id,
    this._name,
    this._group,
    this._cost,
  );

  int get id => _id;

  int get cost => _cost;

  String get name => _name;

  String get group => _group;

  bool get hasOwner => _hasOwner;

  Player get owner => _owner;

  bool get isMortgaged => _isMortgaged;

  set setMortgageStatus(bool condition) {
    _isMortgaged = condition;
  }

  set setIsOwned(bool condition) {
    _hasOwner = condition;
  }

  set setOwner(Player player) {
    _owner = player;
  }
}

class Property extends Square {
  int cost;
  int rent;
  List<int> rentList;
  int houseCost;
  var owner;
  int buildings;
  bool isMortgaged;

  Property({
    required this.cost,
    required this.rent,
    required this.rentList,
    required this.houseCost,
    required this.owner,
    required this.buildings,
    required this.isMortgaged,
    //
    required boardSpace,
    required name,
    required group,
  }) : super(boardSpace, name, group);
}

class Railroad extends Square {
  int cost;
  int rent;

  bool isMortgaged;
  var owner;

  Railroad({
    required this.cost,
    required this.rent,
    required this.owner,
    required this.isMortgaged,
    required boardSpace,
    required name,
    required group,
  }) : super(boardSpace, name, group);
}

class Utility extends Square {
  int cost;
  var owner;
  bool isMortgaged;

  Utility({
    required this.cost,
    required this.isMortgaged,
    required this.owner,
    required boardSpace,
    required name,
    required group,
  }) : super(boardSpace, name, group);
}


//board space attributes
// color/group id e.g., railroad/utilities/ regular property: red/blue
// cost $
// name/id String unique
//hasAction

// icon for chance/ jail /rail road IF special
