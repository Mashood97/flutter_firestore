import 'package:flutter/material.dart';
import 'package:flutter_responsiveness/models/product.dart';
import 'package:flutter_responsiveness/screens/edit_add_product.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<List<Product>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditProduct.routeArgs);
            },
          ),
        ],
      ),
      body: productList != null
          ? ListView.builder(
              itemCount: productList.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(productList[i].productName),
                trailing: Text(productList[i].price.toString()),
                onTap: () => Navigator.of(context)
                    .pushNamed(AddEditProduct.routeArgs, arguments: {
                  'productId': productList[i].productId,
                  'productName': productList[i].productName,
                  'productPrice': productList[i].price,
                }),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
