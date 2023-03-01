import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/controller/product_controller.dart';

class BoxsUpdate extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: productController,
        builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  productController.boxsConter--;
                  productController.update();
                },
              ),
              Text(productController.boxsConter.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  productController.boxsConter++;
                  productController.update();
                },
              ),
            ],
          );
        });
  }
}

class PiecesUpdate extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: productController,
        builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  productController.piecesConter--;
                  productController.update();
                },
              ),
              Text(productController.piecesConter.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  productController.piecesConter++;
                  productController.update();
                },
              ),
            ],
          );
        });
  }
}
