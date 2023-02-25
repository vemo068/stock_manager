import 'package:hive/hive.dart';
import 'package:stock_manager/database/product.dart';

class History {
  int? id;
  int productId;

  int quantity;

  String boxOrIndiv;

  DateTime dateTime;

  History(
      {
        this.id,
        required this.productId,
      required this.quantity,
      required this.dateTime,
      required this.boxOrIndiv});

Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'date': dateTime.toString(),
      'quantity': quantity,
      'boxOrIndiv': boxOrIndiv,
    };
  }



  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'],
      productId: map['product_id'],
      dateTime: DateTime.parse(map['date_time']),
      quantity: map['quantity'],
      boxOrIndiv: map['boxOrIndiv'],
    );
  }

}
