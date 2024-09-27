// import 'package:hive/hive.dart';

// @HiveType(typeId: 1)
// class InvoiceItem extends HiveObject {
//   @HiveField(0)
//   final String name;

//   @HiveField(1)
//   final int price;

//   @HiveField(2)
//   final int quantity;

//   InvoiceItem({
//     required this.name,
//     required this.price,
//     required this.quantity,
//   });
// }

// class InvoiceItemAdapter extends TypeAdapter<InvoiceItem> {
//   @override
//   final int typeId = 1;

//   @override
//   InvoiceItem read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return InvoiceItem(
//       name: fields[0] as String,
//       price: fields[1] as int,
//       quantity: fields[2] as int,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, InvoiceItem obj) {
//     writer
//       ..writeByte(3)
//       ..writeByte(0)
//       ..write(obj.name)
//       ..writeByte(1)
//       ..write(obj.price)
//       ..writeByte(2)
//       ..write(obj.quantity);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is InvoiceItemAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
