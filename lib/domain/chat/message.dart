class Message {
  final String message;

  Message(this.message);

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(json['message'] as String);

  Map<String, dynamic> toJson() => {'message': message};
}
