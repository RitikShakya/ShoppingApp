import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

   final String token;
   final String userId;
   Orders(this.token,this.userId,this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async{
    // final url = Uri.https('fluttershopmeals-default-rtdb.firebaseio.com', '/orders.json');

    var params = {
      'auth': token,
    };
    final url = Uri.https("fluttershopmeals-default-rtdb.firebaseio.com",
        "/orders/$userId.json", params);
    final response = await http.get(url);
    print(response.body);

    final List<OrderItem> listOrders=[];

    final extractedData = json.decode(response.body) as Map<String,dynamic>;
    // if(extractedData.isEmpty){
    //   return;
    // }
    if (extractedData.isEmpty || extractedData['error']!=null) {

      return;

    }


    extractedData.forEach((orderId, orderData) {
      listOrders.add(OrderItem(id: orderId, amount: orderData['amount'], products: (orderData['products'] as List<dynamic>).map((e) => CartItem(id: e['id'], title: e['title'], quantity:e['quantity'], price: e['price'])).toList(), dateTime: DateTime.parse(orderData['dateTime'])));
    });

    _orders=listOrders;
    notifyListeners();
  }
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {

    final timeStamp= DateTime.now();

    var params = {
      'auth': token,
    };
    final url = Uri.https("fluttershopmeals-default-rtdb.firebaseio.com",
        "/orders/$userId.json", params);
    // final url = Uri.https(
    //     'fluttershopmeals-default-rtdb.firebaseio.com', '/orders.json');

    final res =await http.post(url,body: json.encode({
      'amount': total,
      'dateTime': timeStamp.toIso8601String(),
      'products' : cartProducts.map((e) =>{

        'id': e.id,
        'title': e.title,
        'price': e.price,
        'quantity': e.quantity
      }).toList()


    }));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(res.body)['name'],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
