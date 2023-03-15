import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Utlis/Utlis.dart';
import 'Screens/Sneaker.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(),
              Text('Sign Up',
                style: TextStyle(
                  fontSize: 30
                ),
              ),
              SizedBox(
                height: 140,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter username',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                  // do something
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter email',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                  email=value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter password',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                  password=value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Signin()
             ],
          ),
        ),
      ),
    );
  }
  Widget Signin(){
    return loading?CircularProgressIndicator(strokeWidth: 3,color: Colors.black,):ElevatedButton(
        onPressed: (){
          setState(() {
            loading=true;
            _auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Sneaker(email: email,)));
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

