import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/exceptions.dart';
class Auth extends ChangeNotifier{
    String? _token;
    DateTime? expiryDate;
   String? _userId;

  bool get isAuth{
    return token!=null;
  }

  String? get token{
    if(expiryDate!=null&& expiryDate!.isAfter(DateTime.now())&& _token!=null){
      return _token;
    }
    return null;
  }

  String? get userId{

    return _userId;

  }

  Future<void> signUp(String? email,String? password) async{

    try {
      final url = Uri.parse(
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDiUiQpXEmtTraUFMpWNUJUUrhsuJ3WCI4");

      final res = await http.post(url, body: json.encode({
        'returnSecureToken': true,
        'email': email,
        'password': password
      }));

      print(res.body);

      final responseData = json.decode(res.body);
      if(responseData['error']!=null){

        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId= responseData['localId'];
      expiryDate = DateTime.now().add(Duration(seconds:int.parse(responseData['expiresIn'])));

      notifyListeners();
    }
    catch(error){

      throw error;
    }



  }

  Future<void> signIn(String? email, String? password) async {
    try {
      final url = Uri.parse(
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDiUiQpXEmtTraUFMpWNUJUUrhsuJ3WCI4");

      final res = await http.post(url, body: json.encode({
        'returnSecureToken': true,
        'email': email,
        'password': password
      }));

      print(res.body);

      final responseData = json.decode(res.body);
      if(responseData['error']!=null){

        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId= responseData['localId'];
      expiryDate = DateTime.now().add(Duration(seconds:int.parse(responseData['expiresIn'])));

      notifyListeners();
    } catch (error) {
      throw error;

    }
  }

  void logout(){
    _token=null;
    _userId=null;
    expiryDate=null;

    notifyListeners();
  }
}