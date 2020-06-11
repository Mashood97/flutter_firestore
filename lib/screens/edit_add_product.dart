import 'package:flutter/material.dart';
import 'package:flutter_responsiveness/models/product.dart';
import 'package:flutter_responsiveness/providers/product_provider.dart';
import 'package:provider/provider.dart';

class AddEditProduct extends StatefulWidget {
  static const routeArgs = '/add-edit-screen';

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  var routeData;

  void clearData() {
    nameController.text = '';
    priceController.text = '';
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(microseconds: 10), () {
      routeData =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    }).then((_) => routeData == null
        ? new Future.delayed(Duration.zero, () {
            clearData();
            final productProvider =
                Provider.of<ProductProvider>(context, listen: false);
            productProvider.loadValues(Product());
          })
        : Future.delayed(Duration.zero, () {
            print(routeData);
            nameController.text = routeData['productName'];
            priceController.text = routeData['productPrice'].toString();

            final productProvider =
                Provider.of<ProductProvider>(context, listen: false);
            Product p = Product(
              productId: routeData['productId'],
              price: routeData['productPrice'],
              productName: routeData['productName'],
            );
            productProvider.loadValues(p);
          }));
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add or Edit Product'),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Product Name',
                  ),
                  onChanged: (val) => productProvider.changeProductName(val),
                ),
                TextFormField(
                  controller: priceController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Price';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Product Price',
                  ),
                  onChanged: (value) =>
                      productProvider.changeProductPrice(value),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if(_formKey.currentState.validate())
                    {
                    productProvider.saveData();
                    Navigator.of(context).pop();
                  }
                  },
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                ),
                RaisedButton(
                  child: Text('Delete'),
                  onPressed: () {
                    productProvider.removeData();
                    Navigator.of(context).pop();
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
