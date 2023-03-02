import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/components/boxs_update.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/pages/add_category.dart';
import 'package:stock_manager/pages/all_products_page.dart';
import 'package:stock_manager/pages/history_page.dart';
import 'package:stock_manager/pages/homepage.dart';
import 'package:stock_manager/styles/text_style.dart';

class MyDrawer extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Stock Manager',
              style: kHeadingTextStyle,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Get.offAll(HomePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('All Products'),
            onTap: () {
              productController.loadProducts();
              Get.offAll(AllProductsPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Add Category'),
            onTap: () {
              Get.to(AddCategoryPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              productController.getAllHistories();
              Get.offAll(AllHistoryPage());
            },
          ),
        ],
      ),
    );
  }
}
