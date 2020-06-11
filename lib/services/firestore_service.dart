import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_responsiveness/models/product.dart';

class FireStoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveProduct(Product product) {
    return _db
        .collection('Products')
        .document(product.productId)
        .setData(product.createMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('Products').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Product.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeItem(String productId) {
    return _db.collection('Products').document(productId).delete();
  }
}
