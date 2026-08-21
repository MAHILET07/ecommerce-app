import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String tokenKey = "auth_token";
  static const String usernameKey = "username";
  static const String passwordKey = "password";
  static const String ordersKey = "orders";
  static const String favoritesKey = "favorites";

  // =========================
  // Authentication
  // =========================

  Future<void> saveToken(String token) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      tokenKey,
      token,
    );
  }

  Future<String?> getToken() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      tokenKey,
    );
  }

  Future<void> saveUser(
    String username,
    String password,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      usernameKey,
      username,
    );

    await prefs.setString(
      passwordKey,
      password,
    );
  }

  Future<String?> getUsername() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      usernameKey,
    );
  }

  Future<String?> getPassword() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      passwordKey,
    );
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();

    return token != null;
  }

  Future<void> clearToken() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      tokenKey,
    );
  }

  // =========================
  // Orders
  // =========================

  Future<void> saveOrders(
    List<Map<String, dynamic>> orders,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    final jsonString = jsonEncode(orders);

    await prefs.setString(
      ordersKey,
      jsonString,
    );
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final prefs =
        await SharedPreferences.getInstance();

    final jsonString =
        prefs.getString(ordersKey);

    if (jsonString == null ||
        jsonString.isEmpty) {
      return [];
    }

    final decoded =
        jsonDecode(jsonString);

    return List<Map<String, dynamic>>.from(
      decoded,
    );
  }

  Future<void> clearOrders() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      ordersKey,
    );
  }

  // =========================
  // Favorites
  // =========================

  Future<void> saveFavorites(
    List<Map<String, dynamic>> favorites,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    final jsonString =
        jsonEncode(favorites);

    await prefs.setString(
      favoritesKey,
      jsonString,
    );
  }

  Future<List<Map<String, dynamic>>>
      getFavorites() async {
    final prefs =
        await SharedPreferences.getInstance();

    final jsonString =
        prefs.getString(favoritesKey);

    if (jsonString == null ||
        jsonString.isEmpty) {
      return [];
    }

    final decoded =
        jsonDecode(jsonString);

    return List<Map<String, dynamic>>.from(
      decoded,
    );
  }

  Future<void> clearFavorites() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      favoritesKey,
    );
  }
}