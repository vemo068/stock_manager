import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/db_helper.dart';
import 'package:stock_manager/database/product.dart';

class ProductController extends GetxController {
  final dbHelper = DBHelper();
  bool isLoading = true;
  List<Product> products = [];

  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController piecesPerBoxController = TextEditingController();

  void filteredProducts() async {
    final query = searchController.text.toLowerCase();
    products = await dbHelper.searchProducts(query);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void addProduct() {
    Product product = Product(
        category: selectedCategory!,
        name: nameController.text,
        dateAdded: DateTime.now(),
        numIndividualPieces: 0,
        numPiecesPerBox: int.parse(piecesPerBoxController.text));
    dbHelper.insertProduct(product);
  }

  void loadProducts() async {
    isLoading = true;
    products = await dbHelper.getAllProducts();
    isLoading = false;
  }

  void deleteProduct(int productId) async {
    await dbHelper.deleteProduct(productId);
  }

// category

  Category? selectedCategory;
  List<Category> categories = [];

  void loadCategories() async {
    categories = await dbHelper.getAllCategories();
    update();
  }

  Future<void> addCategory(Category category) async {
    dbHelper.insertCategory(category);
    loadCategories();
  }

  Future<void> updateCategory(Category category) async {
    await dbHelper.updateCategory(category);
    loadCategories();
  }

  Future<void> deleteCategory(Category category) async {
    await dbHelper.deleteCategory(category.id!);
    loadCategories();
  }
}
