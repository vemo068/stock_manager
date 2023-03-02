import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/components/drawer.dart';
import 'package:stock_manager/components/product_item.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/pages/add_product.dart';

class CategoryProductsPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  CategoryProductsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProductPage());
        },
        child: Icon(Icons.add),
      ),
      // drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('${productController.selectedCategory!.name}'),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Delete Category",
                  content: Text("delete this Category with products?"),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        productController.deleteCategory();
                        Get.back();
                        Get.back();
                      },
                      child: Text("Delete"),
                    ),
                  ],
                );
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: GetBuilder(
          init: productController,
          builder: (_) {
            return ListView.builder(
              itemCount: productController.categoryProducts.length,
              itemBuilder: (context, index) {
                final product = productController.categoryProducts[index];
                return ProductItem(product: product);
              },
            );
          }),
    );
  }
}
