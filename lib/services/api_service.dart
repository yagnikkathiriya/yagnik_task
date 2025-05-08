import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yagnik_task/model/user_model.dart';

class ApiService {
  final String baseUrl =
      "https://c43d9c37-22a2-4d9b-9f13-923d980cd6ec.mock.pstmn.io";

  ApiService(http.Client client);

  Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=$page'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List users = data['users'] ?? data;

      return users.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> addUser(User user) async {}

  Future<void> updateUser(User user) async {}
}
