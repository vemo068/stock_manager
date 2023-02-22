import 'package:hive/hive.dart';
import 'package:stock_manager/database/product.dart';

part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  Product productId;

  @HiveField(1)
  int quantity;


  @HiveField(3)
  DateTime dateTime;

  History({required this.productId, required this.quantity, required this.dateTime});
}
