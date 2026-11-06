import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/trip_expense.dart';
import '../providers/trip_provider.dart';

class AddTripExpenseScreen extends StatefulWidget {
  const AddTripExpenseScreen({super.key});
  @override
  State<AddTripExpenseScreen> createState() => _AddTripExpenseScreenState();
}

class _AddTripExpenseScreenState extends State<AddTripExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _trip = TextEditingController();
  final _title = TextEditingController();
  final _amount = TextEditingController();
  final _paidBy = TextEditingController();
  final _note = TextEditingController();
  String _category = 'Transport';
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _trip.dispose(); _title.dispose(); _amount.dispose();
    _paidBy.dispose(); _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(context: context, initialDate: _date,
      firstDate: DateTime(2020), lastDate: DateTime.now());
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final expense = TripExpense(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      tripName: _trip.text.trim(), title: _title.text.trim(),
      amount: double.parse(_amount.text.trim()), category: _category,
      date: _date, paidBy: _paidBy.text.trim(), note: _note.text.trim(),
    );
    try {
      await context.read<TripProvider>().addExpense(expense);
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to save trip expense. Try again.')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add trip expense')),
    body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(16), children: [
      TextFormField(controller: _trip, maxLength: 50,
        decoration: const InputDecoration(labelText: 'Trip name'),
        validator: (v) => v == null || v.trim().isEmpty ? 'Enter trip name' : null),
      const SizedBox(height: 12),
      TextFormField(controller: _title, maxLength: 50,
        decoration: const InputDecoration(labelText: 'Expense title'),
        validator: (v) => v == null || v.trim().isEmpty ? 'Enter expense title' : null),
      const SizedBox(height: 12),
      TextFormField(controller: _amount,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(labelText: 'Amount (₹)'),
        validator: (v) {
          final n = double.tryParse((v ?? '').trim());
          return n == null || n <= 0 ? 'Enter an amount greater than 0' : null;
        }),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(value: _category,
        decoration: const InputDecoration(labelText: 'Category'),
        items: const ['Transport', 'Food', 'Stay', 'Tickets', 'Shopping', 'Other']
          .map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
        onChanged: (v) => setState(() => _category = v ?? 'Other')),
      const SizedBox(height: 12),
      TextFormField(controller: _paidBy,
        decoration: const InputDecoration(labelText: 'Paid by (optional)')),
      const SizedBox(height: 12),
      OutlinedButton.icon(onPressed: _pickDate, icon: const Icon(Icons.calendar_month),
        label: Text('Date: ${_date.day}/${_date.month}/${_date.year}')),
      const SizedBox(height: 12),
      TextFormField(controller: _note, maxLines: 2, maxLength: 120,
        decoration: const InputDecoration(labelText: 'Note (optional)')),
      const SizedBox(height: 24),
      FilledButton(onPressed: _saving ? null : _save,
        child: Text(_saving ? 'Saving...' : 'Save trip expense')),
    ])),
  );
}
