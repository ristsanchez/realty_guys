import 'dart:convert';

class LuckCard {
  int id;
  String title;
  String action;

  int tileId;
  String group;

  int rentMultiplier;
  int amount;

  LuckCard({
    this.id = -1,
    this.title = '',
    this.action = '',
    this.tileId = -1,
    this.group = '',
    this.rentMultiplier = -1,
    this.amount = 0,
  });

  factory LuckCard.fromJson(var jsonData) {
    return LuckCard(
      id: jsonData['id'],
      title: jsonData['title'],
      action: jsonData['action'],
      tileId: jsonData['tileId'] ?? -1,
      group: jsonData['group'] ?? '',
      rentMultiplier: jsonData['rentMultiplier'] ?? 1,
      amount: jsonData['amount'] ?? 0,
    );
  }
}
