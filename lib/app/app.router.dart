// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/addresses/addresses_view.dart';
import '../ui/home/home_view.dart';
import '../ui/settings/settings_view.dart';

class Routes {
  static const String homeView = '/';
  static const String settingsView = '/settings-view';
  static const String addressesView = '/addresses-view';
  static const all = <String>{
    homeView,
    settingsView,
    addressesView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.addressesView, page: AddressesView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    SettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SettingsView(),
        settings: data,
      );
    },
    AddressesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddressesView(),
        settings: data,
      );
    },
  };
}
