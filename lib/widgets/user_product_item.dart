import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopinggapp/providers/products_provider.dart';
import 'package:shopinggapp/screens/edit_product_screen.dart';


class UserProductsItem extends StatelessWidget {


  final id;
  final price;
  final title;
  final imageUrl;

  UserProductsItem({required this.imageUrl,required this.id,required this.title,this.price});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      title: Text(title,style: TextStyle(color: Colors.black),),
      subtitle: Text(price.toString(),style: TextStyle(color: Colors.grey),),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [

          IconButton(onPressed: (){Navigator.of(context).pushNamed(EditProductScreen.routename, arguments: id);}, icon: Icon(Icons.edit)),
          IconButton(onPressed: (){Provider.of<Products>(context,listen: false).deleteItem(id);}, icon: Icon(Icons.delete,color: Theme.of(context).errorColor,))
        ]),
      ),
    );
  }
}
