class Scoreboard {
  final String nickname;
  final int score;

  Scoreboard(this.nickname, this.score);

  factory Scoreboard.fromJson(Map<String, dynamic> json) =>
      Scoreboard(json['nickname'] as String, json['score'] as int);

  Map<String, dynamic> toJson() => {'nickname': nickname, 'score': score};
}
