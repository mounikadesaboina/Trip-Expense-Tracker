import 'package:flutter/foundation.dart';
import '../models/trip_expense.dart';
import '../services/trip_storage_service.dart';

class TripProvider extends ChangeNotifier {
  TripProvider(this._storage);
  final TripStorageService _storage;
  final List<TripExpense> _expenses = [];
  bool isLoading = false;
  String? errorMessage;

  List<TripExpense> get expenses => List.unmodifiable(_expenses);
  List<String> get tripNames => _expenses.map((e) => e.tripName).toSet().toList()..sort();
  double get totalSpent => _expenses.fold(0, (sum, e) => sum + e.amount);

  double totalForTrip(String trip) => _expenses
      .where((e) => e.tripName == trip)
      .fold(0, (sum, e) => sum + e.amount);

  Future<void> loadTrips() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final saved = await _storage.load();
      _expenses..clear()..addAll(saved);
    } catch (_) {
      errorMessage = 'Could not load trip expenses. Please retry.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addExpense(TripExpense expense) async {
    _expenses.insert(0, expense);
    notifyListeners();
    try {
      await _storage.save(_expenses);
    } catch (_) {
      _expenses.removeWhere((e) => e.id == expense.id);
      errorMessage = 'Could not save this expense.';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteExpense(String id) async {
    final index = _expenses.indexWhere((e) => e.id == id);
    if (index < 0) return;
    final removed = _expenses.removeAt(index);
    notifyListeners();
    try {
      await _storage.save(_expenses);
    } catch (_) {
      _expenses.insert(index, removed);
      errorMessage = 'Delete failed. Expense restored.';
      notifyListeners();
      rethrow;
    }
  }

  double categoryTotal(String trip, String category) => _expenses
      .where((e) => e.tripName == trip && e.category == category)
      .fold(0, (sum, e) => sum + e.amount);
}
