import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier{

   static const String API_KEY = "AIzaSyDlf5kVW43A7buwGJeEmavGta9Gxu4AO24";
   bool _isAuth =false;

   bool getIsAuth(){
     return _isAuth;
   }
   Future<void> createUserAccount() async {
    //  String url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="+API_KEY;
    //  final response = await http.post(
    //    url,
    //    headers: <String, String>{
    //    'Content-Type': 'application/json; charset=UTF-8',
    //    },
    //      body: jsonEncode(<String, Object>{
    //        'email': "admin@mvm.com",
    //        'password': "password",
    //        'returnSecureToken':true,
    //      }),);


   }
   Future<void> loginUser(String id,String email,String password) async {
     if (id.trim() == "mvm01") {
         final prefs = await SharedPreferences.getInstance();

         String url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="+API_KEY;
         final response = await http.post(
           url,
           headers: <String, String>{
             'Content-Type': 'application/json; charset=UTF-8',
           },
           body: jsonEncode(<String, Object>{
             'email': email,
             'password': password,
             'returnSecureToken':true,
           },),
         );
         if (response.body.contains('idToken')) {
           print("success");
           prefs.setBool('auth', true);
           _isAuth = true;
         }
         else
           print("fail");
         notifyListeners();
     }

     // notifyListeners();
   }
   
   Future<void> checkAuth() async {
     final prefs = await SharedPreferences.getInstance();
     // prefs.clear();
     // prefs.setBool('auth', false);

     if (prefs.containsKey("auth")) {
       _isAuth = true;
     }
     // notifyListeners();
   }


   Future<void> logout() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.clear();
     _isAuth = false;
   }
}