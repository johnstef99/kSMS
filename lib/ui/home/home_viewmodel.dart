import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:ksms/app/app.locator.dart';
import 'package:ksms/app/app.router.dart';
import 'package:ksms/models/chat_model.dart';
import 'package:ksms/services/chats_service.dart';
import 'package:ksms/ui/chatview/chatview_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ChatService _chatService = locator<ChatService>();

  final SmsQuery smsService = SmsQuery();

  String _searchValue;

  List<ChatModel> get chats => _chatService.chats;

  void init() async {
    setBusy(true);
    var gotPerm = await checkPermissions();
    if (gotPerm) await getMessages();
    setBusy(false);
  }

  Future<void> getMessages() async {
    var all = await smsService.getAllSms;
    all.forEach((sms) => _chatService.addSms(sms));
    await _chatService.koulisAI();
  }

  Future<bool> checkPermissions() async {
    if (!(await Permission.sms.isGranted)) {
      setError('sms_perm_not_granted');
      grantPerm();
      return false;
    }
    return true;
  }

  gotoChat(ChatModel chat) {
    _navigationService.navigateToView(ChatView(chat: chat));
  }

  Future<void> menuSelect(String value) async {
    if (value == 'Settings') {
      await _navigationService.navigateTo(Routes.settingsView);
      await _chatService.koulisAI();
      notifyListeners();
      return 0;
    }
  }

  void searchChanged(String value) {
    _searchValue = value;
  }

  Future<void> grantPerm() async {
    var smsStat = await Permission.sms.request();
    if (smsStat.isGranted) {
      clearErrors();
      init();
    }
  }
}
