class Message {
  final String text;
  final bool isMe;
  final bool isTimeSeparator;
  final String time;

  Message({
    required this.text,
    required this.isMe,
    this.isTimeSeparator = false,
    this.time = '',
  });
}
