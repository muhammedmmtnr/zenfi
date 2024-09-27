import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class Invoice extends HiveObject {
  @HiveField(0)
  late String item;

  @HiveField(1)
  late double price;

  Invoice(this.item, this.price);
}
