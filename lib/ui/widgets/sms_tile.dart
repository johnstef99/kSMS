import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class SmsTile extends StatelessWidget {
  const SmsTile({Key key, @required this.sms}) : super(key: key);

  final SmsMessage sms;

  @override
  Widget build(BuildContext context) {
    bool received = sms.kind == SmsMessageKind.Received;
    return Row(
      mainAxisAlignment:
          received ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              left: received ? 10 : 50,
              right: received ? 50 : 10,
              top: 10,
              bottom: 10,
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: received ? Colors.grey[300] : Colors.blue[100],
            ),
            child: Text(sms.body),
          ),
        )
      ],
    );
  }
}
