import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/pages/products_by_category.dart';
import 'package:stock_manager/styles/text_style.dart';

class CategoryItem extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
      child: ListTile(
        tileColor: Color(0xffeeeeee),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          category.name,
          style: kHeadingTextStyle,
        ),
        onTap: () {
          productController.selectedCategory = category;
          productController.loadCategoryProducts();
          Get.to(CategoryProductsPage());
        },
      ),
    );
  }
}
