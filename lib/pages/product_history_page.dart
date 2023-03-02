import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/components/drawer.dart';
import 'package:stock_manager/components/history.dart';
import 'package:stock_manager/controller/product_controller.dart';

class ProductHistoryPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  ProductHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('${productController.selectedProduct!.name} History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder(
            init: productController,
            builder: (_) {
              return ListView.builder(
                itemCount: productController.productHistories.length,
                itemBuilder: (context, index) {
                  return HistoryItem(
                    history: productController.productHistories[index],
                  );
                },
              );
            }),
      ),
    );
  }
}
