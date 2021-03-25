import 'package:flutter/material.dart';
import 'package:ksms/ui/settings/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends ViewModelBuilderWidget<SettingsViewModel> {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget builder(BuildContext context, SettingsViewModel model, Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: Text(model.name),
            onTap: model.setName,
          ),
          ListTile(
            title: Text('Address'),
            subtitle: Text(model.address),
            onTap: model.gotoAddresses,
          ),
          ListTile(
            title: Text('Number'),
            subtitle: Text(model.number),
            onTap: model.setNumber,
          ),
          ListTile(
            title: Text('Sent minutes before'),
            subtitle: Text(model.minBefore == 0
                ? 'random'
                : model.minBefore.toString() + " minutes"),
            onTap: model.setMinBefore,
          ),
        ],
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) {
    return SettingsViewModel();
  }
}
