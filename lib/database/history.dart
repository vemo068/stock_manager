import 'package:hive/hive.dart';
import 'package:stock_manager/database/product.dart';

part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  Product product;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  String boxOrIndiv;

  @HiveField(3)
  DateTime dateTime;

  History(
      {required this.product, required this.quantity, required this.dateTime,required this.boxOrIndiv});
}
