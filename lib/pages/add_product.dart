import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/product.dart';
import 'package:stock_manager/pages/add_category.dart';
import 'package:stock_manager/styles/button_style.dart';
import 'package:stock_manager/styles/text_style.dart';

class AddProductBottomSheet extends StatelessWidget {
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 400.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Product',
            style: kHeadingTextStyle,
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: productController.nameController,
            decoration: InputDecoration(
              labelText: 'Product Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.0),
          productController.categories == []
              ? SizedBox()
              : GetBuilder(
                  init: productController,
                  builder: (_) {
                    return Row(
                      children: [
                        DropdownButton<Category>(
                          value: productController.selectedCategory,
                          hint: Text('Select Category'),
                          onChanged: (Category? value) {
                            productController.selectedCategory = value;
                            productController.update();
                          },
                          items: productController.categories
                              .map((Category category) {
                            return DropdownMenuItem<Category>(
                              value: category,
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Color(int.parse(
                                        category.color,
                                        radix: 16)),
                                  ),
                                  SizedBox(width: 10),
                                  Text(category.name),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        OutlinedButton.icon(
                            // style: kOutlinedButtonStyle,
                            onPressed: () {
                              Get.to(AddCategoryPage());
                            },
                            icon: Icon(Icons.add),
                            label: Text("add category"))
                      ],
                    );
                  }),
          SizedBox(height: 20.0),
          Text(
            'Pieces per Box',
            style: kBodyTextStyle,
          ),
          SizedBox(height: 10.0),
          CupertinoPicker(
            itemExtent: 40.0,
            onSelectedItemChanged: (value) {
              productController.piecesPerBoxController.text =
                  (value + 1).toString();
            },
            children: List<Widget>.generate(
              100,
              (index) => Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Cancel'),
                  style: kOutlinedButtonStyle),
              SizedBox(width: 10.0),
              ElevatedButton(
                style: kPrimaryButtonStyle,
                onPressed: () {
                  // Add product to database
                  productController.addProduct();
                },
                child: Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
