import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/components/category_item.dart';
import 'package:stock_manager/components/drawer.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/product.dart';
import 'package:stock_manager/pages/add_category.dart';
import 'package:stock_manager/pages/add_product.dart';
import 'package:stock_manager/pages/resault_products.dart';

class HomePage extends StatelessWidget {
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = screenWidth < 600 ? 2 : 4;

    double crossAxisSpacing = 16;
    double mainAxisSpacing = 16;
    double childAspectRatio = 1.5;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Stock Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: productController.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      productController.filteredProducts();
                      Get.to(ResultProducts());
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder(
              init: productController,
              builder: (_) {
                if (productController.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: productController.categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: mainAxisSpacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      Category category = productController.categories[index];
                      return CategoryItem(category: category);
                    },
                  );
                  ;
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProductPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
