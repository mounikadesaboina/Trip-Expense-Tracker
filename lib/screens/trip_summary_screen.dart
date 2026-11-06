import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trip_provider.dart';

class TripSummaryScreen extends StatelessWidget {
  const TripSummaryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<TripProvider>();
    const categories = ['Transport', 'Food', 'Stay', 'Tickets', 'Shopping', 'Other'];
    return Scaffold(
      appBar: AppBar(title: const Text('Trip spending summary')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: ListTile(title: const Text('All trip expenses'),
          trailing: Text('₹${store.totalSpent.toStringAsFixed(2)}'))),
        const SizedBox(height: 12),
        Text('Spending by trip', style: Theme.of(context).textTheme.titleLarge),
        ...store.tripNames.map((trip) => Card(child: ExpansionTile(
          title: Text(trip),
          trailing: Text('₹${store.totalForTrip(trip).toStringAsFixed(2)}'),
          children: categories.map((category) {
            final amount = store.categoryTotal(trip, category);
            return ListTile(title: Text(category),
              trailing: Text('₹${amount.toStringAsFixed(2)}'));
          }).toList(),
        ))),
        if (store.tripNames.isEmpty)
          const Padding(padding: EdgeInsets.all(24),
            child: Text('Add trip expenses to see the summary.',
              textAlign: TextAlign.center)),
      ]),
    );
  }
}
