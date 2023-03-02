import 'package:hive/hive.dart';
import 'package:stock_manager/database/product.dart';

class History {
  int? id;
  int productId;

  int quantityBox;
  int quantityPiece;

  DateTime dateTime;

  History(
      {this.id,
      required this.productId,
      required this.quantityBox,
      required this.quantityPiece,
      required this.dateTime,
      });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'datetime': dateTime.toString(),
      'quantity_box': quantityBox,
      'quantity_piece': quantityPiece,
      
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'],
      productId: map['product_id'],
      dateTime: DateTime.parse(map['datetime']),
      quantityBox: map['quantity_box'],
     quantityPiece: map['quantity_piece'],
    );
  }
}
