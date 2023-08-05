import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/data/api/api_client.dart';
import 'package:test_task/data/local_repository/local_repository.dart';
import 'package:test_task/models/user_data_model.dart';
import 'package:test_task/view/person_details.dart';

class UserController extends GetxController {
  final _apiClient = ApiClient();
  final scrollController = ScrollController();
  final LocalStorage localStorage = LocalStorage();
  final currentPage = RxInt(1);

  var isLoading = false.obs;
  var userList = <Data>[].obs;
  var selectedUser = Data().obs;

  int totalPages = 0;

  @override
  void onInit() {
    super.onInit();
    fetchDataWithConnectivityCheck(currentPage.value);
  }

  void fetchUsers(int page) async {
    isLoading.value = true;
    try {
      final userData = await _apiClient.fetchData(page);
      userList.addAll(userData.data!);
      totalPages = userData.totalPages ?? 1;

      await localStorage.saveData(
        'all_data',
        jsonEncode(userList),
      );
      final savedData = await localStorage.getData('all_data');
      if (savedData != null) {
        debugPrint('Saved user data: $savedData');
      } else {
        debugPrint('Failed to save user data');
      }
    } catch (error) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void fetchUserDetails(int userId) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        final userDetails = await _apiClient.fetchDetails(userId);
        selectedUser.value = userDetails;
      }
    } catch (error) {
      rethrow;
    }
  }

  void navigateToUserDetails(int userId) {
    Get.to(() => PersonDetails(
          userId: userId,
        ));
  }

  Future<void> fetchUsersFromLocalStorage() async {
    try {
      final savedData = await localStorage.getData('all_data');
      if (savedData != null) {
        final userDataList = jsonDecode(savedData) as List<dynamic>;
        final userData = UserData.fromJsonList(userDataList);
        userList.assignAll(userData.data!);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchDataWithConnectivityCheck(int page) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      await fetchUsersFromLocalStorage();
    } else {
      try {
        fetchUsers(page);
      } catch (error) {
        rethrow;
      }
    }
  }
}
