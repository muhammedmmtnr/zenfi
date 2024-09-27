class PaymentModel {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  PaymentModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as int,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );
  }

  get userName => null;

  get payMoney => null;

  get avatar => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
