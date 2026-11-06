import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/trip_expense.dart';
import '../providers/trip_provider.dart';

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key, required this.expense});
  final TripExpense expense;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Trip expense details')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const CircleAvatar(radius: 34, child: Icon(Icons.luggage, size: 32)),
      const SizedBox(height: 16),
      Text(expense.title, textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall),
      Text('₹${expense.amount.toStringAsFixed(2)}', textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      _InfoRow('Trip', expense.tripName),
      _InfoRow('Category', expense.category),
      _InfoRow('Date', '${expense.date.day}/${expense.date.month}/${expense.date.year}'),
      _InfoRow('Paid by', expense.paidBy.isEmpty ? 'Not provided' : expense.paidBy),
      _InfoRow('Note', expense.note.isEmpty ? 'No note added' : expense.note),
      const SizedBox(height: 20),
      OutlinedButton.icon(onPressed: () async {
        try {
          await context.read<TripProvider>().deleteExpense(expense.id);
          if (context.mounted) Navigator.pop(context);
        } catch (_) {
          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Delete failed. Try again.')));
        }
      }, icon: const Icon(Icons.delete_outline), label: const Text('Delete expense')),
    ]),
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    title: Text(label), subtitle: SelectableText(value)));
}
