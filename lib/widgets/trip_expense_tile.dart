import 'package:flutter/material.dart';
import '../models/trip_expense.dart';

class TripExpenseTile extends StatelessWidget {
  const TripExpenseTile({super.key, required this.expense, required this.onTap});
  final TripExpense expense;
  final VoidCallback onTap;

  IconData get icon {
    switch (expense.category) {
      case 'Transport': return Icons.directions_bus;
      case 'Food': return Icons.restaurant;
      case 'Stay': return Icons.hotel;
      case 'Tickets': return Icons.confirmation_number;
      case 'Shopping': return Icons.shopping_bag;
      default: return Icons.receipt_long;
    }
  }

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(expense.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('${expense.tripName} • ${expense.category}'),
      trailing: Text('₹${expense.amount.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}
