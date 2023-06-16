class InboxSmsMessage {
  late int date;
  late String address;
  late String body;

  InboxSmsMessage(this.date, this.address, this.body);

  factory InboxSmsMessage.fromJson(dynamic json) {
    return InboxSmsMessage(
        json['date'] as int, json['address'] as String, json['body'] as String);
  }
}
