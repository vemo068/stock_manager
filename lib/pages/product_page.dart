import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/components/boxs_update.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/product.dart';
import 'package:stock_manager/pages/add_product.dart';
import 'package:stock_manager/pages/product_history_page.dart';
import 'package:stock_manager/styles/colors.dart';
import 'package:stock_manager/styles/text_style.dart';

class ProductPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    int quotient = productController.selectedProduct!.numIndividualPieces ~/
        productController.selectedProduct!.numPiecesPerBox;
    int reminder = productController.selectedProduct!.numIndividualPieces %
        productController.selectedProduct!.numPiecesPerBox;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: MaterialButton(
          height: 50,
          onPressed: () {
            productController.updateProduct();
            Get.back();
          },
          color: Colors.blue[900],
          child: Text(
            "Save",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        appBar: AppBar(
          title: Text('Product Details'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Delete Product",
                    content: Text("delete this product?"),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          productController.deleteProduct();
                          Get.back();
                          Get.back();
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                },
                icon: Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  productController.getProductHistories();
                  Get.to(ProductHistoryPage());
                },
                icon: Icon(Icons.history)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: kSubheadingTextStyle,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${productController.selectedProduct!.name}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Category',
                  style: kSubheadingTextStyle,
                ),
                SizedBox(height: 8.0),
                FutureBuilder<Category?>(
                    future: productController.getCategoryById(
                        productController.selectedProduct!.categoryId),
                    builder: (BuildContext context,
                        AsyncSnapshot<Category?> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.name,
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                SizedBox(height: 16.0),
                Text(
                  'Pieces Per Box',
                  style: kSubheadingTextStyle,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${productController.selectedProduct!.numPiecesPerBox}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Number of Boxes',
                  style: kSubheadingTextStyle,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${quotient}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text('Number of Pieces', style: kSubheadingTextStyle),
                SizedBox(height: 8.0),
                Text(
                  '${reminder}',
                  style: TextStyle(fontSize: 18.0),
                ),
                Divider(
                  thickness: 4,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Add Or Remove",
                    style: kHeadingTextStyle,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Boxs",
                      style: kSubheadingTextStyle,
                    ),
                    BoxsUpdate(),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Pieces",
                      style: kSubheadingTextStyle,
                    ),
                    PiecesUpdate(),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
