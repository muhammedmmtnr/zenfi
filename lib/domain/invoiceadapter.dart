import 'package:hive/hive.dart';
import 'package:zenfi/model/invoiceitem.dart';

@HiveType(typeId: 2)
class Invoice extends HiveObject {
  @HiveField(0)
  final String customerName;

  @HiveField(1)
  final String address;

  @HiveField(2)
  final int advance;

  @HiveField(3)
  final String discount;

  @HiveField(4)
  final List<InvoiceItem> items;

  Invoice({
    required this.customerName,
    required this.address,
    required this.advance,
    required this.discount,
    required this.items,
  });
}

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 2;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice(
      customerName: fields[0] as String,
      address: fields[1] as String,
      advance: fields[2] as int,
      discount: fields[3] as String,
      items: (fields[4] as List).cast<InvoiceItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.customerName)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.advance)
      ..writeByte(3)
      ..write(obj.discount)
      ..writeByte(4)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
