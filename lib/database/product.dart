import 'package:hive/hive.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/history.dart';

class Product {
  String name;
  int? id;

  int numPiecesPerBox;

  int numIndividualPieces;

  int categoryId;

  DateTime dateAdded;

  Product({
    this.id,
    required this.name,
    required this.numPiecesPerBox,
    required this.numIndividualPieces,
    required this.categoryId,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pieces_per_box': numPiecesPerBox,
      'individual_pieces': numIndividualPieces,
      'category_id': categoryId,
      'date_added': dateAdded.toString()
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        name: map['name'],
        numPiecesPerBox: map['pieces_per_box'],
        numIndividualPieces: map['individual_pieces'],
        categoryId: map['category_id'],
        dateAdded: DateTime.parse(map['date_added']));
  }
}
