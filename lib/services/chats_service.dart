import 'dart:math';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:injectable/injectable.dart';
import 'package:ksms/models/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class ChatService {
  SharedPreferences prefs;

  List<ChatModel> _chats = [];

  List<ChatModel> get chats => _chats;

  String _name;
  String _address;
  String _number;

  getSavedData() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? 'SET_NAME';
    _address = prefs.getString('address') ?? 'SET_ADDRESS';
    _number = prefs.getString('number') ?? '2';
  }

  setData(String key, String value) async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value.toUpperCase());
  }

  addSms(SmsMessage sms) {
    if (sms.sender != null) {
      var chat = _chats.firstWhere((c) => c.sender == sms.sender, orElse: () {
        return null;
      });

      if (chat == null) {
        _chats.add(ChatModel(sender: sms.sender, smsList: [sms]));
      } else {
        chat.smsList.add(sms);
      }
    }
  }

  sortChats() {
    _chats.sort((a, b) => b.lastSms.date.millisecondsSinceEpoch
        .compareTo(a.lastSms.date.millisecondsSinceEpoch));
  }

  koulisAI() async {
    await getSavedData();
    int randomMin = Random().nextInt(20) + 20;
    var list = _chats.firstWhere((c) => c.sender == '13033').smsList;
    list.clear();
    list.add(
      SmsMessage(
        '13033',
        'ΜΕΤΑΚΙΝΗΣΗ $_number $_name $_address',
        kind: SmsMessageKind.Received,
        date: DateTime.now().subtract(Duration(minutes: randomMin)),
      ),
    );
    list.add(
      SmsMessage(
        '13033',
        '$_number $_name $_address',
        kind: SmsMessageKind.Sent,
        date: DateTime.now().subtract(Duration(minutes: randomMin + 1)),
      ),
    );
    sortChats();
  }
}
