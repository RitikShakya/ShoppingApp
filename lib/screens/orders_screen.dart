import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';


import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';


class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static String routeName= 'orders_screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    setState((){ _isLoading=true;});

    Provider.of<Orders>(context,listen: false).fetchAndSetOrder().then((value) {setState((){_isLoading=false;});});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      final Orderdata=Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders'),),
      drawer: AppDrawer(),
      body:_isLoading? Center(child: CircularProgressIndicator(),): ListView.builder(itemBuilder: (context,i)=>OrderItem(Orderdata.orders[i]),itemCount: Orderdata.orders.length,),
    );
  }
}
