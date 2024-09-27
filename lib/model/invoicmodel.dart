// invoice_model.dart
class Invoice {
  final String invoiceNumber;
  final double amount;
  final bool isPaid;

  Invoice({
    required this.invoiceNumber,
    required this.amount,
    required this.isPaid,
  });
}

// invoice_status.dart
enum InvoiceStatus {
  paid,
  pending,
}
