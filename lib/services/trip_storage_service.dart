import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/trip_expense.dart';

class TripStorageService {
  static const _key = 'triptally_expenses';

  Future<List<TripExpense>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((item) =>
      TripExpense.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<void> save(List<TripExpense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key,
      jsonEncode(expenses.map((expense) => expense.toJson()).toList()));
  }
}
