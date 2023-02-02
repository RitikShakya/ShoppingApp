import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopinggapp/providers/auth.dart';

import 'package:shopinggapp/providers/cart.dart';
import 'package:shopinggapp/providers/orders.dart';
import 'package:shopinggapp/providers/products_provider.dart';
import 'package:shopinggapp/screens/auth_screen.dart';
import 'package:shopinggapp/screens/cart_screen.dart';
import 'package:shopinggapp/screens/edit_product_screen.dart';
import 'package:shopinggapp/screens/orders_screen.dart';
import 'package:shopinggapp/screens/user_products_screen.dart';

import './screens/product_detail_screen.dart';


import './screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> Auth(),),
        
        ChangeNotifierProxyProvider<Auth,Products>(
          update: (context,auth,prevProd) => Products(auth.token??'',auth.userId??'',prevProd==null?[]:prevProd.items),
        create: (ctx)=> Products('','',[]),),
        ChangeNotifierProvider(create: (_) => Cart(),),
        ChangeNotifierProxyProvider<Auth,Orders>(
          update: (context, value, previous) => Orders(value.token??'', value.userId??'',previous==null?[]:previous.orders),
            create: (ctx)=>Orders('','', []),
        )
      ],

      child: Consumer<Auth>(builder: ((context, auth, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Lato'

        ),
        home: auth.isAuth? ProductsOverViewScreen(): AuthScreen(),
        routes: {
          ProductDetails.routeName : (ctx) => ProductDetails(),
          CartScreen.routeName : (context) => CartScreen(),
          OrdersScreen.routeName : (context)=> OrdersScreen(),
          UserProductsScreen.routename : (context)=> UserProductsScreen(),
          EditProductScreen.routename :(context)=>EditProductScreen()


        },

      )
      ),),
    );
  }
}

