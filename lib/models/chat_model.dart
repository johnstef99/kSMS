import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class ChatModel {
  final String sender;
  final List<SmsMessage> smsList;

  ChatModel({
    this.sender,
    this.smsList,
  });

  SmsMessage get lastSms => smsList.first;
}
