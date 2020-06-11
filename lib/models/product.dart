class Product{
  String productId;
  String productName;
  double price;

  Product({this.price,this.productId,this.productName});


  Map<String,dynamic> createMap(){
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': price
    };
  }

  Product.fromFirestore(Map<String,dynamic> firestoreMap): productId = firestoreMap['productId'],
   productName = firestoreMap['productName'],
   price = firestoreMap['productPrice'];
}




