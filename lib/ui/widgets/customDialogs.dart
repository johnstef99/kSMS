import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType { form }

class FormDialog extends HookWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const FormDialog(this.request, this.completer, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = useTextEditingController();
    return AlertDialog(
      title: Text(
        request.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          request.customData['extra'] != null
              ? Text(request.customData['extra'])
              : Container(),
          TextFormField(
            decoration: InputDecoration(
              hintText: request.description ?? 'Enter ${request.title}',
            ),
            keyboardType: request.customData['numberInput']
                ? TextInputType.numberWithOptions(signed: false, decimal: false)
                : TextInputType.text,
            controller: textController,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => completer(DialogResponse(confirmed: false)),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => completer(
            DialogResponse(
              confirmed: true,
              responseData: textController.text,
            ),
          ),
          child: Text('Save'),
        ),
      ],
    );
  }
}
