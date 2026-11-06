import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_expense_tracker/providers/trip_provider.dart';
import 'package:trip_expense_tracker/screens/trip_dashboard_screen.dart';
import 'package:trip_expense_tracker/services/trip_storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('shows empty trip expenses message', (tester) async {
    final provider = TripProvider(TripStorageService());
    await tester.pumpWidget(ChangeNotifierProvider<TripProvider>.value(
      value: provider,
      child: const MaterialApp(home: TripDashboardScreen()),
    ));
    await tester.pumpAndSettle();
    expect(find.text('No trip expenses yet. Add your first expense.'), findsOneWidget);
  });
}
