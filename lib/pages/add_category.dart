import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/controller/product_controller.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/styles/colors.dart';


class AddCategoryPage extends StatelessWidget {
  final ProductController categoryController = Get.find<ProductController>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newCategory = Category(
                      name: _nameController.text,
                      color: getRandomColor(),
                    );
                    categoryController.addCategory(newCategory);
                    Get.back();
                  }
                },
                child: Text('Add Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
String getRandomColor() {
  final random = Random();
  int randomIndex = random.nextInt(colors.length);
  return (colors[randomIndex]);
}