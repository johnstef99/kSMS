import 'package:flutter/material.dart';
import 'package:ksms/models/chat_model.dart';
import 'package:ksms/ui/widgets/sms_tile.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    Key key,
    @required this.chat,
  }) : super(key: key);

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          chat.sender,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              reverse: true,
              itemCount: chat.smsList.length,
              itemBuilder: (context, i) {
                var sms = chat.smsList[i];
                if (i == (chat.smsList.length - 1)) {
                  return Column(
                    children: [
                      Text(sms.date.toString().substring(0, 16)),
                      SmsTile(sms: sms),
                    ],
                  );
                } else {
                  var dif =
                      (sms.date.difference(chat.smsList[i + 1].date).inMinutes);
                  if (dif >= 30) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(sms.date.toString().substring(0, 16)),
                          SmsTile(sms: sms),
                        ],
                      ),
                    );
                  } else
                    return SmsTile(sms: sms);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Send message..',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey[300]),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
