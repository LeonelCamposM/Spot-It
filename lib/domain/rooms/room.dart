class Room {
  final String owner;
  final bool joinable;
  // todo players

  Room(this.owner, this.joinable);

  factory Room.fromJson(Map<String, dynamic> json) =>
      Room(json['owner'] as String, json['joinable'] as bool);

  Map<String, dynamic> toJson() => {'owner': owner, 'joinable': joinable};
}
