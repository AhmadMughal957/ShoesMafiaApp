import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/classes/Cartmodel.dart';
import 'package:foodmafia/signup%20page.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/Sneaker.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading=false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller=TextEditingController();
    TextEditingController passwordcontroller=TextEditingController();
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Container(
          height: scaler.getHeight(105),
          width: scaler.getWidth(100),
          decoration:BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/LoginScreenimage.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: scaler.getHeight(5),
                ),
                Icon(Icons.local_grocery_store_outlined,
                size: scaler.getTextSize(30),),
                Text('Store',
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
                SizedBox(
                  height: 140,
                ),
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 70,
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),

                        hintStyle: TextStyle(color: Colors.white,fontFamily: "WorkSansLight"),
                        filled: true,
                        fillColor: Colors.white24,
                        hintText: 'Enter Email address'),
                    onChanged: (value) {
                      email=value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 70,
                  width: 350,
                  child: TextFormField(
                    decoration:  InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),

                        hintStyle: TextStyle(color: Colors.white,fontFamily: "WorkSansLight"),
                        filled: true,
                        fillColor: Colors.white24,
                        hintText: 'Password'),
                    onChanged: (value) {
                      password=value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                loading?CircularProgressIndicator(color: Colors.grey,):GestureDetector(
                  onTap: () {
                    if(email.isEmpty){
                      final snackBar=SnackBar(
                          content: Text('Fill the email address'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else setState(() {
                      Cart().email=email;
                      print( Cart().email);
                      loading=true;
                      _auth.signInWithEmailAndPassword(email: email, password: password).then((value){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(email: email,)));
                        setState(() {
                          loading=false;
                        });
                      }).onError((error, stackTrace){

                        setState(() {
                          loading=false;
                        });
                        final snackBar=SnackBar(
                          content:  Text('${error.toString()}'),
                          backgroundColor: (Colors.black),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {
                            },
                          ),

                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black12,
                          Colors.black,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 120),
                      child: Text('Do u have Account?'),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                        }, child: Text("Sign up",
                      style: TextStyle(
                     color: Colors.white
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
