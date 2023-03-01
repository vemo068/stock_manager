import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/components/drawer.dart';
import 'package:stock_manager/components/product_item.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/pages/add_product.dart';

class ResultProducts extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  ResultProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Result of ${productController.searchController.text}'),
        
      ),
      body: GetBuilder(
          init: productController,
          builder: (_) {
            return ListView.builder(
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                final product = productController.products[index];
                return ProductItem(product: product);
              },
            );
          }),
    );
  }
}
