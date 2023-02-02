import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopinggapp/screens/cart_screen.dart';
import 'package:shopinggapp/widgets/app_drawer.dart';
import 'package:shopinggapp/widgets/badge.dart';
import 'package:shopinggapp/widgets/product_item.dart';
import 'package:shopinggapp/widgets/products_grid.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';


enum FilterOptions{
  Favorites,
  All
}
class ProductsOverViewScreen extends StatefulWidget {


  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var _showOnlyFav=false;

  var _isLoading=false;
  @override
  void initState() {
    setState((){ _isLoading=true;});

    Provider.of<Products>(context,listen: false).fetchAndSetProducts().then((value) {setState((){_isLoading=false;});});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products'),
      actions: [
        PopupMenuButton(
          onSelected: (FilterOptions selectedVal){


            setState((){
            if(selectedVal==FilterOptions.Favorites){
              _showOnlyFav=true;

            }else{

              _showOnlyFav=false;
            }});
          },
          icon: Icon(Icons.more_vert),itemBuilder: (_) =>[
          PopupMenuItem(child: Text('Favourites'),value: FilterOptions.Favorites,),
          PopupMenuItem(child: Text('All Prods'),value: FilterOptions.All,)
        ],),
        Consumer<Cart>(builder: (_, cart, child) =>
            Badge(child: IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){Navigator.of(context).pushNamed(CartScreen.routeName);},), value: cart.itemCount.toString(), color: Colors.amber) ,

        )

          ]),
      drawer: AppDrawer(),
      body: _isLoading? Center(child: CircularProgressIndicator(),): ProductsGrid(_showOnlyFav),

    );
  }
}
