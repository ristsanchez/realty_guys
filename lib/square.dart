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

//Logic for property controller
//When a different player lands of property
//if not mortgaged
//  if not has houses
//    if owns all from group
//      rent X 2
//    else rent
//  else get rent for # of houses
class Land extends Property {
  final int _rent;
  final int _houseCost;
  final List<int> _rentList;
  int houses = 0;

  int get rent => _rent;

  //should only be called when at least 1 house
  int get rentWithHouses => _rentList[houses - 1];

  int get houseCost => _houseCost;

  bool get hasHouses => houses > 0;

  Land(
    this._rent,
    this._rentList,
    this._houseCost, {
    required name,
    required group,
    required cost,
  }) : super(id, name, group, cost);

class Railroad extends Square {
  int cost;
  int rent;
  factory Land.fromJson(var jsonObject) {
    return Land(
      jsonObject['rent'],
      jsonObject['rentList'].cast<int>(),
      jsonObject['houseCost'],
      id: jsonObject['id'],
      name: jsonObject['name'],
      group: jsonObject['group'],
      cost: jsonObject['cost'],
    );
  }

  @override
  String toString() {
    return '{Name: $name, Id: $id, Type: $group}';
  }
}


  Railroad({
    required id,
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
