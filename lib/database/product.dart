import 'package:hive/hive.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/history.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int piecesPerBox;

  @HiveField(2)
  int numIndividualPieces;

  @HiveField(3)
  Category category;

  @HiveField(4)
  DateTime dateAdded;

 

  Product({
    required this.name,
    required this.piecesPerBox,
    required this.numIndividualPieces,
    required this.category,
    required this.dateAdded,
   
  });
}


