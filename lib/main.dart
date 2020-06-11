import 'package:flutter/material.dart';
import 'package:flutter_responsiveness/providers/product_provider.dart';
import 'package:flutter_responsiveness/screens/edit_add_product.dart';
import 'package:provider/provider.dart';
import './screens/product_list.dart';
import './services/firestore_service.dart';
void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final firestoreService = FireStoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        StreamProvider.value(value: firestoreService.getProducts()),
      ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueAccent[700],
          accentColor: Colors.indigoAccent[700],
          canvasColor: Colors.white,
        ),
        home: ProductList(),
      routes: {
        AddEditProduct.routeArgs:(ctx)=>AddEditProduct(),
      },
      ),
    );
  }
}


