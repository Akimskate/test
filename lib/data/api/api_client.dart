import 'package:flutter/foundation.dart';
import 'package:test_task/models/user_data_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ApiClient {
  static const String baseUrl = 'https://reqres.in/api';

  Future<UserData> fetchData(int page) async {
    final url = Uri.parse('$baseUrl/users?page=$page');
    try {
      final response = await get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        debugPrint('fetched $page');
        return UserData.fromJson(responseData);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Data> fetchDetails(int id) async {
    final url = Uri.parse('$baseUrl/users/$id');
    try {
      final response = await get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return Data.fromJson(responseData);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
