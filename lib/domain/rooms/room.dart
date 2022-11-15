class Room {
  int round;
  bool joinable;
  bool dealedCards;
  bool newRound;
  bool finished;
  bool updatedRound;
  int maximumRounds;

  Room(
    this.round,
    this.joinable,
    this.dealedCards,
    this.newRound,
    this.finished,
    this.updatedRound,
    this.maximumRounds,
  );

  factory Room.fromJson(Map<String, dynamic> json) => Room(
      json['round'] as int,
      json['joinable'] as bool,
      json['dealedCards'] as bool,
      json['newRound'] as bool,
      json['finished'] as bool,
      json['updatedRound'] as bool,
      json['maximumRounds'] as int);

  Map<String, dynamic> toJson() => {
        'round': round,
        'joinable': joinable,
        'dealedCards': dealedCards,
        'newRound': newRound,
        'finished': finished,
        'updatedRound': updatedRound,
        'maximumRounds': maximumRounds,
      };
}
