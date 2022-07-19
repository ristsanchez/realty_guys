class SpecialTile {
  SpecialTile(
    this.id,
    this.name,
    this.group,
  );

  int id;
  String name;
  String group;

  factory SpecialTile.fromJson(var jsonObject) {
    return SpecialTile(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['group'],
    );
  }

  //Main use: debugging
  @override
  String toString() {
    return 'Tile name: $name, Id/board space: $id, Type: $group';
  }
}

abstract class Property {
  final int _id;
  final String _name;
  final String _group;
  final int _cost;

  int _owner = -1; //id from player object
  bool _isMortgaged;

  Property(
    this._id,
    this._name,
    this._group,
    this._cost,
  )   : _owner = -1,
        _isMortgaged = false;

  int get id => _id;

  int get cost => _cost;

  String get name => _name;

  String get group => _group;

  bool get hasOwner => _owner > -1;

  int get ownerId => _owner;

  bool get isMortgaged => _isMortgaged;

  set setMortgageStatus(bool condition) {
    _isMortgaged = condition;
  }

  set setOwner(int playerId) {
    _owner = playerId;
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
  List<int> get rentList => _rentList;

  //should only be called when at least 1 house
  int get rentWithHouses => _rentList[houses - 1];

  int get houseCost => _houseCost;

  bool get hasHouses => houses > 0;

  Land(
    this._rent,
    this._rentList,
    this._houseCost, {
    required id,
    required name,
    required group,
    required cost,
  }) : super(id, name, group, cost);

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

class Railroad extends Property {
  final List rentList = [25, 50, 100, 200];

  Railroad({
    required id,
    required name,
    required group,
    required cost,
  }) : super(id, name, group, cost);

  factory Railroad.fromJson(var jsonObject) {
    return Railroad(
      id: jsonObject['id'],
      name: jsonObject['name'],
      group: jsonObject['group'],
      cost: jsonObject['cost'],
    );
  }
}

class Utility extends Property {
  int multiplier = 4;

  Utility({
    required id,
    required name,
    required group,
    required cost,
  }) : super(id, name, group, cost);

  factory Utility.fromJson(var jsonObject) {
    return Utility(
      id: jsonObject['id'],
      name: jsonObject['name'],
      group: jsonObject['group'],
      cost: jsonObject['cost'],
    );
  }
}


//board space attributes
// color/group id e.g., railroad/utilities/ regular property: red/blue
// cost $
// name/id String unique
//hasAction

// icon for chance/ jail /rail road IF special
