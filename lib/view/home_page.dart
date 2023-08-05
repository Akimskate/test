import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/user_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Obx(
          () {
            if (userController.isLoading.value == true) {
              return const CircularProgressIndicator();
            } else if (userController.userList.isNotEmpty) {
              return UsersList(userController: userController);
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList({
    super.key,
    required this.userController,
  });
  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userController.userList.length,
      itemBuilder: ((context, index) {
        final user = userController.userList[index];
        return SizedBox(
          height: 100,
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 5, 16, 12),
              leading: FittedBox(
                child: CachedNetworkImage(
                  imageUrl: user.avatar ?? '',
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 30,
                  ),
                  placeholder: (context, url) => const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
              title: Text(
                '${user.lastName} ${user.firstName}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              subtitle: Text(user.email ?? ''),
              onTap: () {
                userController.navigateToUserDetails(user.id ?? 0);
              },
            ),
          ),
        );
      }),
    );
  }
}
