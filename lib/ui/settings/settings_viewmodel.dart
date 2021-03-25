import 'package:ksms/app/app.locator.dart';
import 'package:ksms/app/app.router.dart';
import 'package:ksms/services/chats_service.dart';
import 'package:ksms/ui/widgets/customDialogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final ChatService _chatService = locator<ChatService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String get name => _chatService.name;

  String get address => _chatService.address;

  String get number => _chatService.number;

  int get minBefore => _chatService.minBefore;

  Future<void> setName() async {
    DialogResponse response = await _dialogService.showCustomDialog(
        variant: DialogType.form,
        title: 'Set Name',
        description: name,
        customData: {
          'numberInput': false,
        });
    if (response.confirmed) {
      String newName = response.responseData;
      print(newName);
      if (newName.isNotEmpty) {
        _chatService.setData('name', newName);
        notifyListeners();
      }
    }
  }

  Future<void> setNumber() async {
    DialogResponse response = await _dialogService.showCustomDialog(
        variant: DialogType.form,
        title: 'Set Number',
        description: number,
        customData: {
          'numberInput': true,
        });
    if (response.confirmed) {
      String newNuber = response.responseData;
      if (newNuber.isNotEmpty) {
        _chatService.setData('number', newNuber);
        notifyListeners();
      }
    }
  }

  Future<void> gotoAddresses() async {
    await _navigationService.navigateTo(Routes.addressesView);
    notifyListeners();
  }

  Future<void> setMinBefore() async {
    DialogResponse response = await _dialogService.showCustomDialog(
        variant: DialogType.form,
        title: 'Set minutes before last message',
        description: '$minBefore minutes',
        customData: {
          'numberInput': true,
          'extra': 'Set to 0 for random number between 20-40 min'
        });
    if (response.confirmed) {
      String newNuber = response.responseData;
      if (newNuber.isNotEmpty) {
        int min = int.tryParse(newNuber) ?? 0;
        _chatService.setMinBefore(min);
        notifyListeners();
      }
    }
  }
}
