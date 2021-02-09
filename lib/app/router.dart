import 'package:ksms/ui/home/home_view.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(page: HomeView,initial: true),
  ],
)
class $MyRouter {}
