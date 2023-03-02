import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/database/history.dart';
import 'package:stock_manager/database/product.dart';

class HistoryItem extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  final History history;

  HistoryItem({required this.history});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: FutureBuilder<Product?>(
              future: productController.getProductById(history.productId),
              builder:
                  (BuildContext context, AsyncSnapshot<Product?> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.name);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              }),
          subtitle: Text(
              'Time: ${DateFormat.yMd().add_jm().format(history.dateTime)}\nBoxes: ${history.quantityBox} Pieces: ${history.quantityPiece}'),
        ),
      ),
    );
  }
}
