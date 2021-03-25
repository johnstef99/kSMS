import 'package:ksms/services/chats_service.dart';
import 'package:ksms/ui/addresses/addresses_view.dart';
import 'package:ksms/ui/home/home_view.dart';
import 'package:ksms/ui/settings/settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    StackedRoute(page: HomeView, initial: true),
    StackedRoute(page: SettingsView),
    StackedRoute(page: AddressesView),
  ],
  dependencies: [
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ChatService),
    Presolve(
        classType: SharedPreferences,
        presolveUsing: SharedPreferences.getInstance),
  ],
)
class App {}
