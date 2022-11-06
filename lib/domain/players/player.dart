class Player {
  final String nickname;
  final String icon;
  final String displayedCard;
  final int cardCount;
  final int stackCardsCount;

  Player(this.nickname, this.icon, this.displayedCard, this.cardCount,
      this.stackCardsCount);

  factory Player.fromJson(Map<String, dynamic> json) => Player(
      json['nickname'] as String,
      json['icon'] as String,
      json["displayedCard"] as String,
      json["cardCount"] as int,
      json["stackCardsCount"] as int);

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'icon': icon,
        "displayedCard": displayedCard,
        "cardCount": cardCount,
        "stackCardsCount": stackCardsCount
      };
}
