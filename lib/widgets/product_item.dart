import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopinggapp/providers/auth.dart';
import 'package:shopinggapp/screens/product_detail_screen.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';




class ProductItem extends StatelessWidget {
  //const ProductItem({Key? key}) : super(key: key);

  // String id;
  // String title;
  // String imageUrl;
  // double price;
  //
  // ProductItem({required this.id,required this.title,required this.imageUrl,required this.price});

  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Product>(context);
    final cartData =Provider.of<Cart>(context,listen: false);
    final auth = Provider.of<Auth>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(title: Text(productData.title,textAlign: TextAlign.center),backgroundColor: Colors.black54,
            leading: IconButton(icon:Icon(productData.isFavorite?Icons.favorite:Icons.favorite_border),color: Theme.of(context,).accentColor, onPressed: () { productData.toggleFavourite(auth.token!,auth.userId!); },),
            trailing: IconButton(
              icon:Icon(Icons.add_shopping_cart),color: Theme.of(context).accentColor,onPressed: (){cartData.addItem(productData.id, productData.price, productData.title);

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added To Cart'),backgroundColor: Colors.grey,duration:Duration(milliseconds: 2000),action: SnackBarAction(label: 'Undo',onPressed: (){cartData.removeSingleItem(productData.id);}),));
              },
            ),
          ) ,

          child: GestureDetector(
            onTap: (){Navigator.of(context).pushNamed(ProductDetails.routeName as String,arguments: productData.id, );},
              child: Image.network(productData.imageUrl,fit: BoxFit.cover,))
      ),
    );
  }
}
