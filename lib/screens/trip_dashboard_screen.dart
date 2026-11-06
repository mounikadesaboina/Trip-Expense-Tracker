import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trip_provider.dart';
import '../widgets/trip_expense_tile.dart';
import 'add_trip_expense_screen.dart';
import 'trip_detail_screen.dart';
import 'trip_summary_screen.dart';

class TripDashboardScreen extends StatelessWidget {
  const TripDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TripProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('TripTally'), actions: [
        IconButton(tooltip: 'Trip summary',
          onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const TripSummaryScreen())),
          icon: const Icon(Icons.insights)),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const AddTripExpenseScreen())),
        icon: const Icon(Icons.add), label: const Text('Add trip expense')),
      body: RefreshIndicator(
        onRefresh: store.loadTrips,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Card(color: Theme.of(context).colorScheme.primary, child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('TOTAL TRIP SPENDING',
                style: TextStyle(color: Colors.white70, letterSpacing: 1)),
              const SizedBox(height: 8),
              Text('₹${store.totalSpent.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
              Text('${store.tripNames.length} trip(s) recorded',
                style: const TextStyle(color: Colors.white)),
            ]),
          )),
          const SizedBox(height: 20),
          Text('Recent trip expenses', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          if (store.isLoading)
            const Padding(padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()))
          else if (store.errorMessage != null)
            Column(children: [
              Text(store.errorMessage!, textAlign: TextAlign.center),
              TextButton(onPressed: store.loadTrips, child: const Text('Retry')),
            ])
          else if (store.expenses.isEmpty)
            const Padding(padding: EdgeInsets.all(36),
              child: Text('No trip expenses yet. Add your first expense.',
                textAlign: TextAlign.center))
          else
            ...store.expenses.map((expense) => TripExpenseTile(
              expense: expense,
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => TripDetailScreen(expense: expense))),
            )),
          const SizedBox(height: 90),
        ]),
      ),
    );
  }
}
