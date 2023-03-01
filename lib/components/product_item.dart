import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/database/product.dart';
import 'package:stock_manager/pages/product_page.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    int quotient = product.numIndividualPieces ~/ product.numPiecesPerBox;
    int reminder = product.numIndividualPieces % product.numPiecesPerBox;
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          productController.selectedProduct = product;
          productController.getCategoryById();
          Get.to(ProductPage());
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Boxs: $quotient',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Individual pieces: ${reminder}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
