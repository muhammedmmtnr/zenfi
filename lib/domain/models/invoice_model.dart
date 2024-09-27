import 'package:hive/hive.dart';
import 'package:zenfi/model/invoiceitem.dart';

@HiveType(typeId: 1)
class Invoice extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int price;

  @HiveField(2)
  final int quantity;

  Invoice({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

@HiveType(typeId: 2)
class Invoiceitem extends HiveObject {
  @HiveField(0)
  late final String customerName;

  @HiveField(1)
  late final String address;

  @HiveField(2)
  late final int advance;

  @HiveField(3)
  late final String discount;

  @HiveField(4)
  late final List<InvoiceItem> items;

  // Invoice({
  //   required this.customerName,
  //   required this.address,
  //   required this.advance,
  //   required this.discount,
  //   required this.items,
  // });
}
