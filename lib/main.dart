import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodmafia/Screens/HomeScreen.dart';
import 'package:foodmafia/signup%20page.dart';
import 'package:provider/provider.dart';
import 'cartpage.dart';
import 'classes/Cartmodel.dart';
import 'Screens/Sneaker.dart';
import 'classes/caatalogmodel.dart';
import 'package:firebase_core/firebase_core.dart';

import 'loginScreen.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    ),
  );
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    final _auth= FirebaseAuth.instance;
    final user= _auth.currentUser;
      if(user !=null) {
        Timer(Duration(seconds: 2), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>HomeScreen(email: Cart().email,)));
        });

      }else{
        Timer(Duration(seconds: 2), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      }
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 400,
                child: Image.asset('assets/images/Logo.png')
            ),
            Container(
              height: 5,
              width: 200,
              child:  LinearProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.green,
              ),
            )

          ],
        ),
      ),
    );
  }
}




