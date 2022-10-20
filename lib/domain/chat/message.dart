class Message {
  final String message;
  final int time;

  Message(this.message, this.time);

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(json['message'] as String, json['time'] as int);

  Map<String, dynamic> toJson() => {'message': message, 'time': time};
}
