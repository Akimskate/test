import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/user_controller.dart';

import '../models/user_data_model.dart';

class PersonDetails extends StatelessWidget {
  final int userId;

  const PersonDetails({required this.userId});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    final user = userController.userList
        .firstWhere((user) => user.id == userId, orElse: () => Data());

    if (user.id != null) {
      userController.fetchUserDetails(user.id!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar ?? ''),
                radius: 75,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              user.email ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
