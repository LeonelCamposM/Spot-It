class Message {
  final String message;
  final int time;
  final String icon;

  Message(this.message, this.time, this.icon);

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      json['message'] as String, json['time'] as int, json["icon"] as String);

  Map<String, dynamic> toJson() =>
      {'message': message, 'time': time, "icon": icon};
}
