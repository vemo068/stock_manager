import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:stock_manager/controller/product_controller.dart';

import 'package:stock_manager/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  
  runApp(StockManager());
}

class StockManager extends StatelessWidget {
  StockManager({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
   
    return GetMaterialApp(
      
      home: HomePage(),
    );
  }
}
