import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/components/drawer.dart';
import 'package:stock_manager/components/history.dart';
import 'package:stock_manager/controller/product_controller.dart';

class AllHistoryPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  AllHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('All History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder(
            init: productController,
            builder: (_) {
              return ListView.builder(
                itemCount: productController.allHistories.length,
                itemBuilder: (context, index) {
                  return HistoryItem(
                    history: productController.allHistories[index],
                  );
                },
              );
            }),
      ),
    );
  }
}
