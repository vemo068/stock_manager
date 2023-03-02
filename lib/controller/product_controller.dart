import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/db_helper.dart';
import 'package:stock_manager/database/history.dart';
import 'package:stock_manager/database/product.dart';

class ProductController extends GetxController {
  final dbHelper = DBHelper();
  bool isLoading = true;
  List<Product> products = [];
  Product? selectedProduct;
  int boxsConter = 0;
  int piecesConter = 0;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController piecesPerBoxController = TextEditingController();
  List<History> productHistories = [];
  List<History> allHistories = [];

  void filteredProducts() async {
    final query = searchController.text.toLowerCase();
    products = await dbHelper.searchProducts(query);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<Product?> getProductById(int id) async {
    return await dbHelper.getProductById(id);
  }

  void getAllHistories() async {
    allHistories = await dbHelper.getAllHistories();
    update();
  }

  void getProductHistories() async {
    productHistories =
        await dbHelper.getHistoriesByProductId(selectedProduct!.id!);
    update();
  }

  void addProduct() async {
    Product product = Product(
        categoryId: selectedCategory!.id!,
        name: nameController.text,
        dateAdded: DateTime.now(),
        numIndividualPieces: 0,
        numPiecesPerBox: int.parse(piecesPerBoxController.text));
    await dbHelper.insertProduct(product);
    nameController.clear();
    selectedCategory = null;
    piecesPerBoxController.clear();
  }

  void updateProduct() async {
    Product product = selectedProduct!;
    product.numIndividualPieces += boxsConter * product.numPiecesPerBox;
    product.numIndividualPieces += piecesConter;
    await dbHelper.updateProduct(product);
    History history = History(
        productId: product.id!,
        quantityBox: boxsConter,
        quantityPiece: piecesConter,
        dateTime: DateTime.now());
    await dbHelper.createHistory(history);
    boxsConter = 0;
    piecesConter = 0;
    loadProducts();

    loadCategoryProducts();
  }

  void loadProducts() async {
    isLoading = true;
    products = await dbHelper.getAllProducts();
    isLoading = false;
    update();
  }

  void deleteProduct() async {
    await dbHelper.deleteProduct(selectedProduct!.id!);
    loadProducts();
    loadCategoryProducts();
  }

// category

  Category? selectedCategory;
  Category? productCategory;
  List<Product> categoryProducts = [];
  List<Category> categories = [];

  void loadCategories() async {
    isLoading = true;
    categories = await dbHelper.getAllCategories();
    isLoading = false;
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

  Future<void> deleteCategory() async {
    await dbHelper.deleteCategory(selectedCategory!.id!);
    selectedCategory = null;
    loadCategories();
  }

  void loadCategoryProducts() async {
    if (selectedCategory == null) {
    } else {
      categoryProducts =
          await dbHelper.getProductsByCategoryId(selectedCategory!.id!);
    }

    update();
  }

  Future<Category?> getCategoryById(int id) async {
    return
        await dbHelper.getCategoryById(id);
  }
}
