class Player {
  String nickname;
  String icon;
  String displayedCard;
  int cardCount;
  int stackCardsCount;

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
