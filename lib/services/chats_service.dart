import 'dart:math';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:ksms/app/app.locator.dart';
import 'package:ksms/models/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  final SharedPreferences prefs = locator<SharedPreferences>();

  List<ChatModel> _chats = [];

  List<ChatModel> get chats => _chats;
  List<String> get addresses => _addresses;
  String get name => _name;
  String get address => _address;
  String get number => _number;
  int get minBefore => _minBefore;

  String _name;
  String _address;
  String _number;
  List<String> _addresses;
  int _minBefore;

  getSavedData() async {
    _name = prefs.getString('name') ?? 'SET_NAME';
    _address = prefs.getString('address') ?? 'SET_ADDRESS';
    _number = prefs.getString('number') ?? '2';
    _minBefore = prefs.getInt('minBefore') ?? 0;
    _addresses = prefs.getStringList('addresses') ?? [];
  }

  setData(String key, String value) async {
    prefs.setString(key, value.toUpperCase());
    switch (key) {
      case 'name':
        _name = value;
        break;
      case 'address':
        _address = value;
        break;
      case 'number':
        _number = value;
        break;
    }
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

  addAddress(String add) {
    _addresses.add(add);
    prefs.setStringList('addresses', _addresses);
  }

  removeAddress(String add) {
    if (_addresses.remove(add)) prefs.setStringList('addresses', _addresses);
  }

  setMinBefore(int min) {
    _minBefore = min;
    prefs.setInt('minBefore', _minBefore);
  }

  sortChats() {
    _chats.sort((a, b) => b.lastSms.date.millisecondsSinceEpoch
        .compareTo(a.lastSms.date.millisecondsSinceEpoch));
  }

  List<SmsMessage> smsPair(DateTime dateTime, String number) => [
        SmsMessage(
          '13033',
          'ΜΕΤΑΚΙΝΗΣΗ $number $_name $_address',
          kind: SmsMessageKind.Received,
          date: dateTime,
        ),
        SmsMessage(
          '13033',
          '$number $_name $_address',
          kind: SmsMessageKind.Sent,
          date: dateTime.add(
            Duration(minutes: 1),
          ),
        ),
      ];

  koulisAI() async {
    await getSavedData();
    //if user setted minBefore use it
    int randomMin = _minBefore == 0 ? Random().nextInt(20) + 20 : _minBefore;
    var list = _chats.firstWhere((c) => c.sender == '13033').smsList;
    list.clear();
    DateTime n = DateTime.now();
    list.addAll(smsPair(n.subtract(Duration(minutes: randomMin)), _number));
    int extraSms = Random().nextInt(4) + 8; //[2-8]
    var numbers = ["2", "6"];
    for (int i = 0; i != extraSms; i++) {
      int ranMin = Random(i).nextInt(120) + 30;
      String numb = numbers[Random(i).nextInt(2)];
      list.addAll(
          smsPair(n.subtract(Duration(minutes: ranMin, days: i + 1)), numb));
    }
    sortChats();
  }
}
