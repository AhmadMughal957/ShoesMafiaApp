
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/Front_Screens/HomeScreen.dart';

class loginScreen with ChangeNotifier{
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool loading=false;

    Future Login(email,password)async{
      loading=true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
    _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
}
}