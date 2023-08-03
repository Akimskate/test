import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:test_task/view/home_page.dart';
import 'package:test_task/view/person_details.dart';

class AppNavigator {
  static const initial = Routes.homePage;

  static final routes = [
    GetPage(name: Routes.homePage, page: () => HomePage()),
    GetPage(name: Routes.usedDetails, page: () => PersonDetails()),
  ];
}

abstract class Routes {
  static const homePage = '/home';
  static const usedDetails = '/details';
}
