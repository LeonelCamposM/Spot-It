class Room {
  int round;
  bool joinable;

  Room(this.round, this.joinable);

  factory Room.fromJson(Map<String, dynamic> json) =>
      Room(json['round'] as int, json['joinable'] as bool);

  Map<String, dynamic> toJson() => {'round': round, 'joinable': joinable};
}
