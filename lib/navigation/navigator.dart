import 'package:get/get.dart';
import 'package:test_task/view/home_page.dart';
import 'package:test_task/view/person_details.dart';

class AppNavigator {
  static const initial = Routes.homePage;

  static final routes = [
    GetPage(name: Routes.homePage, page: () => HomePage()),
    GetPage(
      name: Routes.usedDetails,
      page: () {
        final userId = Get.arguments['userId'] as int;
        return PersonDetails(userId: userId);
      },
    ),
  ];
}

abstract class Routes {
  static const homePage = '/home';
  static const usedDetails = '/details';
}
