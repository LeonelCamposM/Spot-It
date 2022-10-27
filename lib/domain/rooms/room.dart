class Room {
  int round;
  bool joinable;
  bool dealedCards;

  Room(this.round, this.joinable, this.dealedCards);

  factory Room.fromJson(Map<String, dynamic> json) => Room(json['round'] as int,
      json['joinable'] as bool, json['dealedCards'] as bool);

  Map<String, dynamic> toJson() =>
      {'round': round, 'joinable': joinable, 'dealedCards': dealedCards};
}
