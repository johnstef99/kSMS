import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:ksms/app/locator.dart';
import 'package:ksms/models/chat_model.dart';
import 'package:ksms/services/chats_service.dart';
import 'package:ksms/ui/chatview/chatview_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel<List<SmsMessage>> {
  final NavigationService _navigationService = locator<NavigationService>();
  final ChatService _chatService = locator<ChatService>();

  final SmsQuery smsService = SmsQuery();

  String _searchValue;

  List<ChatModel> get chats => _chatService.chats;

  @override
  Future<List<SmsMessage>> futureToRun() async {
    var all = await smsService.getAllSms;
    all.forEach((sms) => _chatService.addSms(sms));
    await _chatService.koulisAI();
    return all;
  }

  gotoChat(ChatModel chat) {
    _navigationService.navigateToView(ChatView(chat: chat));
  }

  Future<void> menuSelect(String value) async {
    _chatService.setData(value, _searchValue);
    await _chatService.koulisAI();
    notifyListeners();
  }

  void searchChanged(String value) {
    _searchValue = value;
  }
}
