import 'package:flutter/material.dart';
import 'package:ksms/ui/addresses/addresses_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddressesView extends ViewModelBuilderWidget<AddressesViewModel> {
  const AddressesView({Key key}) : super(key: key);

  @override
  Widget builder(BuildContext context, AddressesViewModel model, Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addresses'),
      ),
      body: ListView.builder(
        itemCount: model.addresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(model.addresses[index]),
            onTap: () => model.selectAddress(model.addresses[index]),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => model.removeAddress(model.addresses[index])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: model.addAddress,
      ),
    );
  }

  @override
  AddressesViewModel viewModelBuilder(BuildContext context) {
    return AddressesViewModel();
  }
}
