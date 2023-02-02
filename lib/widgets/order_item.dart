import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopinggapp/providers/orders.dart' as ord;
class OrderItem extends StatefulWidget {
  //const OrderItem({Key? key}) : super(key: key);
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(margin: EdgeInsets.all(10),
    color: Colors.amber,
    child: Column(children: [
      ListTile(title: Text('\$${widget.order.amount}'),
      subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),),
        trailing: IconButton(icon: expanded?Icon(Icons.expand_less):Icon(Icons.expand_more),onPressed: (){
          setState((){expanded= !expanded;});
        },),
      ),
      if(expanded)Container(height: min(200,widget.order.products.length*10+10),
      child: ListView(children: widget.order.products.map((e) =>
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

            Text(e.title ),



            Text('${e.quantity}x\$${e.price }')
          ],


          )

      ).toList(),),)
    ]),);
  }
}
