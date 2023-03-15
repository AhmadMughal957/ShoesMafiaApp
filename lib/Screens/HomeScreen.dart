import 'package:animation_list/animation_list.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/Screens/Boots.dart';
import 'package:foodmafia/classes/Cartmodel.dart';
import 'package:foodmafia/classes/GetData.dart';
import 'package:provider/provider.dart';
import '../classes/App images.dart';
import '../loginScreen.dart';
import 'Joggers.dart';
import 'Loafers.dart';
import 'Sneaker.dart';

class HomeScreen extends StatefulWidget {
  var email;
   HomeScreen({ required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState(email:email);
}

class _HomeScreenState extends State<HomeScreen> {
  var email;
  final auth=FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  _HomeScreenState({required this.email});
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context,snapshot){
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor:  Color(0xFFE7ECEF),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor:  Color(0xFFE7ECEF),
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.touch_app_sharp),
                label: 'My Ads',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'My Order',
              ),
            ],
          ),
          key: _key,
          drawer:  Drawer(
            backgroundColor: Color(0xFFE7ECEF),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                  ),
                  title: const Text('Orders'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                  ),
                  title: const Text('Sign Out'),
                  onTap: () {
                    auth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }).onError((error ,stackTrace) {
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
                  },
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: snapshot.data==ConnectivityResult.none?Text('Please check your internet connection'):SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 45, left: 10,right: 10),
                        child: InkWell(
                          onTap: () => _key.currentState!.openDrawer(),
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Icon(Icons.account_circle),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: scaler.getHeight(15),
                        width: scaler.getWidth(77),
                        child: Padding(
                          padding:  EdgeInsets.only(top:5),
                          child: TextField(
                            decoration:  InputDecoration(
                              suffixIcon: Icon(Icons.my_location),
                              border: OutlineInputBorder(
                                borderRadius:BorderRadius.circular(20),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2.0),
                              ),
                              hintText: 'Enter your address',
                            ),

                            onSubmitted: (String value) {
                              debugPrint(value);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50,left: 10),
                        child: Container(
                            height: 10,
                            width: 10,
                            child: Icon(Icons.notifications)),
                      )
                    ],
                  ),
          Container(
            height: 700,
            width: 400,
            child: AnimationList(
                children: [
                  Card(
                    child: InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Sneaker(email: null,)));},
                      child: Container(
                        height: 250,
                        width: 400,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Joggers(email: null,)));},
                      child: Container(
                        height: 250,
                        width: 400,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Loafers(email: null,)));},
                      child: Container(
                        height: 250,
                        width: 400,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Boots(email: null,)));},
                      child: Container(
                        height: 250,
                        width: 400,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Loafers(email: null,)));},
                      child: Container(
                        height: 250,
                        width: 400,
                      ),
                    ),
                  ),
                ],
            duration: 2000,
            reBounceDepth: 20.0,
        ),
          ),


                ],
              ),
            )
          ),
        );
      },
    );
  }
}
