import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/navigation/navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Test task',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[300]),
      initialRoute: AppNavigator.initial,
      getPages: AppNavigator.routes,
    );
  }
}
