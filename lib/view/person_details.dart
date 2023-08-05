import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/user_controller.dart';
import 'package:test_task/data/local_repository/local_repository.dart';

import '../models/user_data_model.dart';

class PersonDetails extends StatelessWidget {
  final int userId;

  PersonDetails({super.key, required this.userId});
  final LocalStorage localStorage = LocalStorage();

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
              child: CachedNetworkImage(
                imageUrl: user.avatar ?? '',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 75,
                ),
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 75,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                errorWidget: (context, url, error) => const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 75,
                  child: Icon(Icons.error, color: Colors.white),
                ),
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
