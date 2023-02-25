import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/database/product.dart';
import 'package:stock_manager/pages/add_product.dart';

class HomePage extends StatelessWidget {
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller:productController.searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder(
              init: productController,
              builder: (productController) {
                if (productController.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      final Product product =
                          productController.products[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle:
                            Text('${product.numPiecesPerBox} pieces per box'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            productController.deleteProduct(product.id!);
                          },
                        ),
                        onTap: () {
                          //  Get.toNamed('/product-details', arguments: product.id);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AddProductBottomSheet();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
