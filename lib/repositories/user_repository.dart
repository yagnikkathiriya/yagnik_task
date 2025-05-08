// ignore_for_file: implementation_imports

import 'dart:convert';
import 'package:http/src/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagnik_task/services/api_service.dart';
import 'package:yagnik_task/model/user_model.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(Client client, {required this.apiService});

  Future<List<User>> fetchUsers({int page = 1}) async {
    final users = await apiService.fetchUsers(page);
    final localUsers = await getLocalUsers();
    return [...localUsers, ...users];
  }

  Future<User> fetchUserById(int id) async {
    return await apiService.fetchUserById(id);
  }

  Future<void> addUserLocally(User user) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> localUsers = prefs.getStringList('local_users') ?? [];
    localUsers.insert(0, jsonEncode(user.toJson()));
    await prefs.setStringList('local_users', localUsers);
  }

  Future<void> updateUserLocally(User user) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> localUsers = prefs.getStringList('local_users') ?? [];
    List<User> updatedUsers = localUsers.map((u) => User.fromJson(jsonDecode(u))).toList();

    final index = updatedUsers.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      updatedUsers[index] = user;
      List<String> updatedStrings = updatedUsers.map((u) => jsonEncode(u.toJson())).toList();
      await prefs.setStringList('local_users', updatedStrings);
    }
  }

  Future<List<User>> getLocalUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> localUsers = prefs.getStringList('local_users') ?? [];
    return localUsers.map((u) => User.fromJson(jsonDecode(u))).toList();
  }
}
