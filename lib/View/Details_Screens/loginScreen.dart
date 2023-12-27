import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/View/Front_Screens/HomeScreen.dart';
import 'package:foodmafia/View/Details_Screens/signup%20page.dart';
import 'package:foodmafia/ViewModel/Cartmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _passwordVisible=true;
  void initState() {
    _passwordVisible = false;
  }
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: scaler.getHeight(5),
                ),
                Container(
                  height: scaler.getHeight(40),
                  width: scaler.getHeight(50),
                  child: Image.asset('assets/images/pngegg.png'),
                ),
                SizedBox(
                  height: scaler.getHeight(10),
                ),
              
                SizedBox(
                  height: scaler.getHeight(8),
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
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: scaler.getHeight(10),
                  width: scaler.getWidth(85),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    decoration:  InputDecoration(
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
                        hintText: 'Password'),
                    onChanged: (value) {
                      password=value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                loading?CircularProgressIndicator(color: Colors.white,):GestureDetector(
                  onTap: () {
                    if(email.isEmpty){
                      final snackBar=SnackBar(
                          content: Text('Fill the email address'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else setState(() async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('email', email);
                      loading=true;
                      _auth.signInWithEmailAndPassword(email: email, password: password).then((value){
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
                      child: Text('Do you have Account?'),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                        }, child: Text("Sign up",
                      style: TextStyle(
                     color: Colors.black
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
