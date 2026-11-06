class TripExpense {
  const TripExpense({
    required this.id,
    required this.tripName,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.paidBy = '',
    this.note = '',
  });

  final String id;
  final String tripName;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String paidBy;
  final String note;

  Map<String, dynamic> toJson() => {
    'id': id, 'tripName': tripName, 'title': title, 'amount': amount,
    'category': category, 'date': date.toIso8601String(),
    'paidBy': paidBy, 'note': note,
  };

  factory TripExpense.fromJson(Map<String, dynamic> json) => TripExpense(
    id: json['id'] as String,
    tripName: json['tripName'] as String,
    title: json['title'] as String,
    amount: (json['amount'] as num).toDouble(),
    category: json['category'] as String,
    date: DateTime.parse(json['date'] as String),
    paidBy: (json['paidBy'] as String?) ?? '',
    note: (json['note'] as String?) ?? '',
  );
}
