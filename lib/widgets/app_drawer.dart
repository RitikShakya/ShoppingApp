import 'package:flutter/material.dart';
import 'package:shopinggapp/providers/auth.dart';
import 'package:shopinggapp/screens/orders_screen.dart';
import 'package:shopinggapp/screens/user_products_screen.dart';

import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(title: Text(' SHOPPER '),
        automaticallyImplyLeading: false,),
        Divider(),
        ListTile(leading: Icon(Icons.shopping_cart),title: Text('Shop'),onTap: (){Navigator.of(context).pushNamed('/');},)
        ,Divider()
        ,ListTile(leading: Icon(Icons.reorder),title: Text('Order'),onTap: (){Navigator.of(context).pushNamed(OrdersScreen.routeName);},),
        Divider(),
        ListTile(leading: Icon(Icons.house_rounded),title: Text('User Products'),onTap: (){Navigator.of(context).pushNamed(UserProductsScreen.routename);},),

        Divider(),
        ListTile(leading: Icon(Icons.logout),title: Text('Log Out'),onTap: (){
          Navigator.of(context).pop();

          Provider.of<Auth>(context,listen: false).logout();},),

      ]),
    );
  }
}
