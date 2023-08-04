import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/data/api/api_client.dart';
import 'package:test_task/models/user_data_model.dart';
import 'package:test_task/view/person_details.dart';

class UserController extends GetxController {
  final _apiClient = ApiClient();
  final scrollController = ScrollController();

  var isLoading = false.obs;
  var userList = <Data>[].obs;
  var selectedUser = Data().obs;

  final currentPage = RxInt(1);

  @override
  void onInit() {
    super.onInit();
    fetchUsers(currentPage.value);
    //fetchUsers(1);
  }

  void fetchUsers(int page) async {
    isLoading.value = true;
    try {
      final userData = await _apiClient.fetchData(page);
      userList.addAll(userData.data!);
    } catch (error) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void fetchUserDetails(int userId) async {
    try {
      final userDetails = await _apiClient.fetchDetails(userId);
      selectedUser.value = userDetails;
    } catch (error) {
      rethrow;
    } finally {}
  }

  void navigateToUserDetails(int userId) {
    Get.to(() => PersonDetails(
          userId: userId,
        ));
  }
}
