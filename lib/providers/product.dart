import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({required this.id,required this.title,required this.imageUrl,required this.description,required this.price, this.isFavorite=false});


  Future<void> toggleFavourite(String token,String userId) async{
    final oldStatus = isFavorite;
    isFavorite=!isFavorite;


    var params = {
      'auth': token,
    };
    final url = Uri.https("fluttershopmeals-default-rtdb.firebaseio.com",
        "/userFavs/$userId/$id.json", params);
    // final url = Uri.https('fluttershopmeals-default-rtdb.firebaseio.com', '/products/$id.json');

    try{
    final res=await http.put(url,body: json.encode(
       isFavorite,
    ));
    if(res.statusCode>=400){

      isFavorite= oldStatus;
      notifyListeners();
    }

    }
    catch(error){
      isFavorite= oldStatus;
      notifyListeners();
    }


    notifyListeners();
  }

}