import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ksms/models/chat_model.dart';

const List<MaterialColor> _colors = const [
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.blue,
  Colors.green,
];

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key key,
    @required this.chat,
    this.onTap,
  }) : super(key: key);

  //TODO: change that to get only lastSms and sender
  final ChatModel chat;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor:
            _colors[Random(chat.sender.length).nextInt(_colors.length - 1)],
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      title: Text(chat.sender ?? 'error'),
      subtitle: Text(
        chat.lastSms.body,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(date()),
    );
  }

  String date() {
    var smsDate = chat.lastSms.date;
    Duration dif = DateTime.now().difference(smsDate);
    if (dif.inDays == 1)
      return ' χθές';
    else if (dif.inDays > 1)
      return dif.inDays.toString() + ' ${smsDate.day}/${smsDate.month}';
    else if (dif.inHours == 1)
      return dif.inHours.toString() + ' ώρα';
    else if (dif.inHours > 1)
      return dif.inHours.toString() + ' ώρες';
    else if (dif.inMinutes == 1)
      return dif.inMinutes.toString() + ' λεπτό';
    else if (dif.inMinutes >= 1)
      return dif.inMinutes.toString() + ' λεπτά';
    else
      return dif.inSeconds.toString() + ' δευτ';
  }
}
