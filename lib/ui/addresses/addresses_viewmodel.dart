import 'package:ksms/app/app.locator.dart';
import 'package:ksms/services/chats_service.dart';
import 'package:ksms/ui/widgets/customDialogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddressesViewModel extends BaseViewModel {
  final ChatService _chatService = locator<ChatService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<String> get addresses => _chatService.addresses;

  void selectAddress(String address) {
    _chatService.setData('address', address);
    _navigationService.back();
  }

  Future<void> addAddress() async {
    DialogResponse response = await _dialogService.showCustomDialog(
        variant: DialogType.form,
        title: 'New Address',
        customData: {'numberInput': false});
    if (response.confirmed) {
      _chatService.addAddress(response.responseData);
      notifyListeners();
    }
  }

  Future<void> removeAddress(String address) async {
    DialogResponse response = await _dialogService.showDialog(
      title: 'Remove Address',
      description: 'Do you want to remove $address',
      cancelTitle: 'No',
      buttonTitle: 'Yes',
    );
    if (response.confirmed) {
      _chatService.removeAddress(address);
      notifyListeners();
    }
  }
}
