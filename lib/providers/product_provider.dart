import 'package:flutter/foundation.dart';
import 'package:flutter_responsiveness/models/product.dart';
import '../services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final service = FireStoreService();
  String _name;
  String _productId;
  double _price;
  var uuid = Uuid();

//Getters:

  String get getName => _name;
  double get getPrice => _price;

//Setters:

  void changeProductName(String val) {
    _name = val;
    notifyListeners();
  }

  void changeProductPrice(String val) {
    _price = double.parse(val);
    notifyListeners();
  }

  loadValues(Product product) {
    _name = product.productName;
    _price = product.price;
    _productId = product.productId;
  }

  void saveData() {
    if (_productId == null) {
      var newProduct =
          Product(productName: getName, productId: uuid.v4(), price: getPrice);
      service.saveProduct(newProduct);
    } else {
      var updatedProduct =
          Product(productName: getName, price: getPrice, productId: _productId);
      service.saveProduct(updatedProduct);
    }
  }

  void removeData() {
    service.removeItem(_productId);
  }
}
