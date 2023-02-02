import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';



class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName ='CartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartData=Provider.of<Cart>(context);
    return Scaffold
      (
      appBar: AppBar(title: Text('Your Cart'),),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',style: TextStyle(fontSize: 20),),
                  Spacer(),
                  Chip(label: Text('\$${CartData.totalAmount.toStringAsFixed(2)}',style: TextStyle(color: Colors.white),),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(onPressed:CartData.totalAmount<=0?null:() async{
                    await Provider.of<Orders>(context,listen: false).addOrder(CartData.items.values.toList(), CartData.totalAmount);CartData.clear();}, child: Text('Order Now',style: TextStyle(color: Theme.of(context).primaryColor),))
                ],

              ),
            ),
          ),
          SizedBox(height: 15,),
          Expanded(child: ListView.builder(itemBuilder: (context,i)=>CartItem(id: CartData.items.values.toList()[i].id, title: CartData.items.values.toList()[i].title, quantity: CartData.items.values.toList()[i].quantity, price: CartData.items.values.toList()[i].price, productId:CartData.items.keys.toList()[i] ,),itemCount: CartData.items.length,))
        ],

      ),
    );
  }
}
