import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodmafia/View/Details_Screens/loginScreen.dart';
import 'package:foodmafia/View/Front_Screens/HomeScreen.dart';

import 'package:provider/provider.dart';
import 'View/cartpage.dart';
import 'ViewModel/Cartmodel.dart';
import 'View/Front_Screens/Sneaker.dart';
import 'Models/caatalogmodel.dart';
import 'package:firebase_core/firebase_core.dart';


/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].
var emaill;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner:false,
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
              MaterialPageRoute(builder: (context) =>HomeScreen()));
        });

      }else{
        Timer(Duration(seconds: 2), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 400,
                child: Image.asset('assets/images/Logo.png')
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 5,
              width: 200,
              child:  LinearProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.black,
              ),
            )

          ],
        ),
      ),
    );
  }
}




