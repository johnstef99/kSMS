import 'package:flutter/material.dart';
import 'package:ksms/app/app.locator.dart';
import 'package:ksms/app/app.router.dart';
import 'package:ksms/ui/widgets/customDialogs.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  registerDialogs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kSMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}

void registerDialogs() {
  final dialogService = locator<DialogService>();

  dialogService.registerCustomDialogBuilders({
    DialogType.form: (context, request, completer) =>
        FormDialog(request, completer),
  });
}
