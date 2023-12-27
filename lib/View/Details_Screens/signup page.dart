import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/View/Front_Screens/HomeScreen.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  bool loading=false;
  late String email;
  late String password;
  bool _passwordVisible=true;

  void initState() {
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: scaler.getHeight(40),
                  width: scaler.getHeight(50),
                  child: Image.asset('assets/images/pngegg.png'),
                ),
                SizedBox(
                  height: scaler.getHeight(10),
                ),
                Text('Sign up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: scaler.getHeight(4),
                ),
                Container(
                  height: scaler.getHeight(10),
                  width: scaler.getWidth(85),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.drive_file_rename_outline,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),

                        hintStyle: TextStyle(color: Colors.black,fontFamily: "WorkSansLight"),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: 'Enter User Name'),
                    onChanged: (value) {
                      // do something
                    },
                  ),
                ),
                Container(
                  height: scaler.getHeight(10),
                  width: scaler.getWidth(85),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),

                        hintStyle: TextStyle(color: Colors.black,fontFamily: "WorkSansLight"),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: 'Enter Email address'),
                    onChanged: (value) {
                      email=value;
                    },
                  ),
                ),

                Container(
                  height: scaler.getHeight(10),
                  width: scaler.getWidth(85),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          }, icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      )),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),

                        hintStyle: TextStyle(color: Colors.black,fontFamily: "WorkSansLight"),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: 'Enter Password'),
                    onChanged: (value) {
                      password=value;
                    },
                  ),
                ),

                Signin()
               ],
            ),
          ),
        ),
      ),
    );
  }
  Widget Signin(){
    return loading?CircularProgressIndicator(strokeWidth: 3,color: Colors.black,):ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black
      ),
        onPressed: (){
          setState(() {
            loading=true;
            _auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
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
        child: Text('Sign up'));
  }
}

