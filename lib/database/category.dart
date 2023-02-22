import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String colorHexCode;

  Category({
    required this.name,
    required this.colorHexCode,
  });
}
