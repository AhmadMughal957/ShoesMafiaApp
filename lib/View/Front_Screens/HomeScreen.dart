import 'dart:io';

import 'package:animation_list/animation_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/View/Front_Screens/Boots.dart';
import 'package:foodmafia/View/Details_Screens/loginScreen.dart';
import 'package:foodmafia/View/Front_Screens/Slides.dart';
import 'package:foodmafia/ViewModel/Cartmodel.dart';
import 'package:foodmafia/Models/GetData.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ViewModel/Viewmodel.dart';
import '../cartpage.dart';
import '../../Models/App images.dart';
import 'Joggers.dart';
import 'Loafers.dart';

import 'Sneaker.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {

   HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool pressed1=false;
  bool pressed2=false;
  bool pressed3=false;
  bool pressed4=false;
  bool pressed5=false;
  var name;
  var users=[];
  @override
  void call() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var emaill = prefs.getString('email');
    print(emaill);
  }
@override

  void initState()  {
    call();
    super.initState();
  }
  final auth=FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _key = GlobalKey();


  _HomeScreenState();
  @override
  Widget build(BuildContext context) {

    ScreenScaler scaler = ScreenScaler()..init(context);
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context,snapshot){
        return WillPopScope(
          onWillPop: () => _onBackPressed(context),
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Cartpage(email: null,)
                    ));
                  },
                  child: Padding(
                    padding: scaler.getPaddingLTRB(0, 1, 5, 0),
                    child: badges.Badge(
                      badgeContent: Consumer<Cart>
                        (builder: (context,cart,child){
                        return Text('${cart.items.length}');
                      },
                      ),
                      child: Icon(Icons.shopping_cart,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text('HOME',style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontSize: 25
              ),),
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
                      color: Color(0xFFE7ECEF),
                    ),
                    child: Text(''),
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
                child: Center(
                  child: snapshot.data==ConnectivityResult.none?Text('Please check your internet connection'):SingleChildScrollView(
            scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
            Container(
              height: scaler.getHeight(87),
              width: scaler.getWidth(95),
              child: AnimationList(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<List<Viewmodel>>(
                            stream: GetData().View1(),
                            builder: (context, snapshot){
                              if(snapshot.hasError){
                                return Text('something is wrong${snapshot.error}');
                              }
                              else if(snapshot.hasData){
                                final users=snapshot.data!;
                                if(users[0].Value==1){
                                  pressed1=true;
                                }
                                else{
                                  pressed1=false;
                                }
                                return pressed1?InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            Sneaker(email: null,)));
                                  },
                                  child: Container(
                                      decoration:BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 5),
                                            ),
                                            BoxShadow(
                                              offset: const Offset(0,0),
                                            ),
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: const Offset(0,0),
                                            )
                                          ]
                                      ),
                                      height: scaler.getHeight(40),
                                      width: scaler.getWidth(95),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: pressed1?Card(
                                              child: Text('Sneakers',style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  fontStyle: FontStyle.italic
                                              ),),
                                            ):Text(''),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: scaler.getHeight(30),
                                            width: scaler.getWidth(75),
                                            child: Image.asset(
                                                'assets/images/Sneaker.png'),
                                          )

                                        ],
                                      )
                                  ),
                                ):Text('');
                              }
                              else return Center(child: CircularProgressIndicator(),);
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<List<Viewmodel>>(
                            stream: GetData().View2(),
                            builder: (context, snapshot){
                              if(snapshot.hasError){
                                return Text('something is wrong${snapshot.error}');
                              }
                              else if(snapshot.hasData){
                                final users=snapshot.data!;
                                if(users[0].Value==1){
                                  pressed2=true;
                                }
                                else{
                                  pressed2=false;
                                }
                                return pressed2?InkWell(
                                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Joggers(email: null,)));},
                                  child: Container(
                                    decoration:BoxDecoration(

                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),

                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0,1),
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0,0),
                                          )
                                        ]
                                    ),
                                    height: scaler.getHeight(40),
                                    width: scaler.getWidth(95),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: pressed2?Card(
                                            child: Text('Runners',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                fontStyle: FontStyle.italic
                                            ),),
                                          ):Text(''),
                                        ),
                                        Container(
                                            height: scaler.getHeight(30),
                                            width: scaler.getWidth(75),
                                            child: Image.asset('assets/images/Joggers.png')),
                                      ],
                                    ),
                                  ),
                                ):Text('');
                              }
                              else return Center(child: CircularProgressIndicator(),);
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<List<Viewmodel>>(
                            stream: GetData().View3(),
                            builder: (context, snapshot){
                              if(snapshot.hasError){
                                return Text('something is wrong${snapshot.error}');
                              }
                              else if(snapshot.hasData){
                                final users=snapshot.data!;
                                if(users[0].Value==1){
                                  pressed3=true;
                                }
                                else{
                                  pressed3=false;
                                }
                                return pressed3?InkWell(
                                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Loafers(email: null,)));},
                                  child: Container(
                                    decoration:BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),
                                          BoxShadow(
                                            offset: const Offset(0,0),
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0,0),
                                          )
                                        ]
                                    ),
                                    height: scaler.getHeight(40),
                                    width: scaler.getWidth(95),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: pressed3?Card(
                                            child: Text('Loafers',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                fontStyle: FontStyle.italic
                                            ),),
                                          ):Text(''),
                                        ),
                                        Container(
                                            height: scaler.getHeight(30),
                                            width: scaler.getWidth(75),
                                            child: Image.asset('assets/images/Loafers.png')),
                                      ],
                                    ),
                                  ),
                                ):Text('');
                              }
                              else return Center(child: CircularProgressIndicator(),);
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        StreamBuilder<List<Viewmodel>>(
                            stream: GetData().View4(),
                            builder: (context, snapshot){
                              if(snapshot.hasError){
                                return Text('something is wrong${snapshot.error}');
                              }
                              else if(snapshot.hasData){
                                final users=snapshot.data!;
                                if(users[0].Value==1){
                                  pressed4=true;
                                }
                                else{
                                  pressed4=false;
                                }
                                return pressed4? InkWell(
                                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Boots(email: null,)));},
                                  child: Container(
                                    decoration:BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),
                                          BoxShadow(
                                            offset: const Offset(0,0),
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0,0),
                                          )
                                        ]
                                    ),
                                    height: scaler.getHeight(40),
                                    width: scaler.getWidth(95),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: pressed4?Card(
                                            child: Text('Boots',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                fontStyle: FontStyle.italic
                                            ),),
                                          ):Text(''),
                                        ),
                                        Container(
                                          height: scaler.getHeight(30),
                                          width: scaler.getWidth(75),
                                          child:Image.asset('assets/images/Boots.png') ,
                                        )

                                      ],
                                    ),
                                  ),
                                ):Text('');
                              }
                              else return Center(child: CircularProgressIndicator(),);
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        StreamBuilder<List<Viewmodel>>(
                            stream: GetData().View5(),
                            builder: (context, snapshot){
                              if(snapshot.hasError){
                                return Text('something is wrong${snapshot.error}');
                              }
                              else if(snapshot.hasData){
                                final users=snapshot.data!;
                                if(users[0].Value==1){
                                  pressed5=true;
                                }
                                else{
                                  pressed5=false;
                                }
                                return pressed5?  InkWell(
                                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Slides(email: null,)));},
                                  child: Container(
                                    decoration:BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),
                                          BoxShadow(
                                            offset: const Offset(2,0),
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0,0),
                                          )
                                        ]
                                    ),
                                    height: scaler.getHeight(40),
                                    width: scaler.getWidth(95),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: pressed5?Card(
                                            child: Text('Sandal',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                fontStyle: FontStyle.italic
                                            ),),
                                          ):Text(''),
                                        ),
                                        Container(
                                            height: scaler.getHeight(30),
                                            width: scaler.getWidth(75),
                                            child: Image.asset('assets/images/Sandles.png')),
                                      ],
                                    ),
                                  ),
                                ):Text('');
                              }
                              else return Center(child: CircularProgressIndicator(),);
                            }
                        ),



                      ],
              duration: 2000,
              reBounceDepth: 20.0,
          ),
            ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
                ));
                });
  }
  Future<bool> _onBackPressed(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm exit'),
        content: Text('Are you sure you want to exit?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return result ?? false;
  }



}

