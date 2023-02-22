import 'package:hive/hive.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/history.dart';
import 'package:stock_manager/database/product.dart';
class ProductManager {
  Box<Product> _productBox = Hive.box<Product>('products');
  Box<Category> _categoryBox = Hive.box<Category>('categories');
  Box<History> _historyBox=Hive.box<History>('historys')

  List<Product> get allProducts => _productBox.values.toList();

  List<Category> get allCategories => _categoryBox.values.toList();

  List<Product> getProductsByCategory(Category category) {
    return _productBox.values
        .where((product) => product.category == category)
        .toList();
  }

  List<Product> searchProducts(String query) {
    return _productBox.values
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void addProduct(Product product) {
    _productBox.add(product);
  }

  void updateProduct(Product product) {
    product.save();
  }

  void removeProduct(Product product) {
    product.delete();
  }

  void addPieces(Product product, int numPieces) {
    product.numIndividualPieces += numPieces;
    History history =
        History(product: product,quantity: numPieces,dateTime:DateTime.now(),boxOrIndiv: "قطع" );
    _historyBox.add(history);
    product.save();
  }

  void addBoxes(Product product, int numBoxes) {
    product.numIndividualPieces += (numBoxes * product.piecesPerBox);
    History history =
        History(action: 'Added $numBoxes boxes', date: DateTime.now());
    product.history.add(history);
    product.save();
  }

  void removePieces(Product product, int numPieces) {
    product.numIndividualPieces -= numPieces;
    History history =
        History(action: 'Removed $numPieces pieces', date: DateTime.now());
    product.history.add(history);
    product.save();
  }

  void removeBoxes(Product product, int numBoxes) {
    product.numIndividualPieces -= (numBoxes * product.piecesPerBox);
    History history =
        History(action: 'Removed $numBoxes boxes', date: DateTime.now());
    product.history.add(history);
    product.save();
  }

  void addCategory(Category category) {
    _categoryBox.add(category);
  }

  void updateCategory(Category category) {
    category.save();
  }

  void removeCategory(Category category) {
    category.delete();
  }
}
