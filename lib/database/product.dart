import 'package:hive/hive.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/history.dart';

class Product {
  String name;
  int? id;

  int numPiecesPerBox;

  int numIndividualPieces;

  Category category;

  DateTime dateAdded;

  Product({
    this.id,
    required this.name,
    required this.numPiecesPerBox,
    required this.numIndividualPieces,
    required this.category,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'numPiecesPerBox': numPiecesPerBox,
      'numIndividualPieces': numIndividualPieces,
      'category': category,
     'date_added':dateAdded.toString()
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      numPiecesPerBox: map['numPiecesPerBox'],
      numIndividualPieces: map['numIndividualPieces'],
      category: map['category'],
      dateAdded:DateTime.parse(map['date_added'])
      
    );
  }
}
