import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String tokenKey = "auth_token";
  static const String usernameKey = "username";
  static const String passwordKey = "password";
  static const String ordersKey = "orders";

  // =========================
  // Authentication
  // =========================

  // Save login token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      tokenKey,
      token,
    );
  }

  // Get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      tokenKey,
    );
  }

  // Save registered user
  Future<void> saveUser(
    String username,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      usernameKey,
      username,
    );

    await prefs.setString(
      passwordKey,
      password,
    );
  }

  // Get saved username
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      usernameKey,
    );
  }

  // Get saved password
  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      passwordKey,
    );
  }

  // Check login status
  Future<bool> isLoggedIn() async {
    final token = await getToken();

    return token != null;
  }

  // Logout
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(
      tokenKey,
    );
  }

  // =========================
  // Orders
  // =========================

  // Save orders
  Future<void> saveOrders(
    List<Map<String, dynamic>> orders,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(orders);

    await prefs.setString(
      ordersKey,
      jsonString,
    );
  }

  // Get saved orders
  Future<List<Map<String, dynamic>>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(
      ordersKey,
    );

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(jsonString);

    return List<Map<String, dynamic>>.from(
      decoded,
    );
  }

  // Clear all saved orders
  Future<void> clearOrders() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(
      ordersKey,
    );
  }
}