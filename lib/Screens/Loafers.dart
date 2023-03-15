import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/classes/GetData.dart';
import 'package:foodmafia/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'Detailpage.dart';
import '../classes/Cartmodel.dart';
import '../classes/Catalogmodel2.dart';
import '../classes/View.dart';
import '../classes/caatalogmodel.dart';
import '../cartpage.dart';
import '../classes/App images.dart';

class Loafers extends StatefulWidget {
  var email;
  Loafers({required this.email });

  @override
  State<Loafers> createState() => _LoafersState(email:email);
}

class _LoafersState extends State<Loafers> {
  var email;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  var price = 0;
  final auth=FirebaseAuth.instance;
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String? _selectedLocation;
  int count=0;
  var list;
  bool check=false;

  _LoafersState({required this.email});
  @override
  Widget build(BuildContext context) {

    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(


      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(

              leading: Icon(Icons.exit_to_app),
              title: const Text('Sign out'),
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

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(left:10,top:40),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                      decoration:  InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderRadius: BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),

                          hintStyle: TextStyle(color: Colors.black,fontFamily: "WorkSansLight"),
                          filled: true,
                          fillColor: Color(0xFFE7ECEF),
                          hintText: 'Search'),
                      onChanged: (value) {
                      },
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Cartpage(email: email,)
                      ));
                    },
                    child: badges.Badge(
                      badgeContent: Consumer<Cart>
                        (builder: (context,cart,child){
                        return Text('${cart.items.length}');
                      },
                      ),
                      child: Icon(Icons.shopping_cart,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            StreamBuilder(
                stream: GetData().readUser3(),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    CircularProgressIndicator();
                  }
                  else if(snapshot.hasData){
                    list=snapshot.data!;
                    print(list[0].Value);
                    if(list[0].Value=='List'){
                      check=true;
                    }
                    else{
                      check=false;
                    }
                  }
                  return check?Container(

                    height: 732,
                    width: 420,
                    child: StreamBuilder(
                      stream: GetData().Loafers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('something is wrong${snapshot.error}');
                        }
                        else if (snapshot.hasData) {
                          final users = snapshot.data!;
                          return GridView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Consumer<Cart>(builder: (context, cart, child) {
                                  return Container(
                                    decoration:BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade600,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: const Offset(-5,0),
                                          ),
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: const Offset(5,0),
                                          )
                                        ]
                                    ),

                                    child: Column(
                                      children: [
                                        Card(
                                          child: Container(
                                            height: 100,
                                            width: 170,
                                            decoration:BoxDecoration(
                                                image: new DecorationImage(
                                                  image: new AssetImage(AppImages.fastFood),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade600,
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 5),
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    offset: const Offset(-5,0),
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    offset: const Offset(5,0),
                                                  )
                                                ]
                                            ),
                                          ),
                                        ),
                                        Card(
                                          child: Container(
                                            height: 70,
                                            width: 190,

                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },

                                ),
                              );
                            },

                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 20,
                                crossAxisCount: 2),);
                        }
                        else
                          return Center(child: CircularProgressIndicator(),);
                      },
                    ),
                  )
                      :Container(
                    height: 732,
                    width: 420,
                    child: StreamBuilder(
                      stream: GetData().Loafers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('something is wrong${snapshot.error}');
                        }
                        else if (snapshot.hasData) {
                          final users = snapshot.data!;
                          return ListView.builder(
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Consumer<Cart>(builder: (context, cart, child) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Detail(
                                          index: index,
                                          image:users[index].image,
                                          name: users[index].name,
                                          price:users[index].price,
                                          desc: users[index].desc,
                                          colors:users[index].color,
                                          size: users[index].size,
                                        )));
                                      },
                                      child: Container(
                                        decoration:BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: const Offset(0, 5),
                                              ),
                                              BoxShadow(
                                                color: Colors.white,
                                                offset: const Offset(-5,0),
                                              ),
                                              BoxShadow(
                                                color: Colors.white,
                                                offset: const Offset(5,0),
                                              )
                                            ]
                                        ),

                                        child: Row(
                                          children: [
                                            Card(
                                              child: Container(
                                                height: 150,
                                                width: 120,
                                                child: CachedNetworkImage(
                                                  imageUrl: '${users[index].image}',
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                          colorFilter:
                                                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) => CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                ),
                                                decoration:BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        offset: const Offset(0, 5),
                                                      ),
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        offset: const Offset(-5,0),
                                                      ),
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        offset: const Offset(5,0),
                                                      )
                                                    ]
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:10,left: 0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height:60,
                                                    width: 80,
                                                    child: Text('${users[index].name}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold)
                                                    ),
                                                  ),
                                                  DropdownButton(
                                                    hint: Text('Available Size'), // Not necessary for Option 1
                                                    value: _selectedLocation,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _selectedLocation = newValue;
                                                      });
                                                    },
                                                    items: _locations.map((location) {
                                                      return DropdownMenuItem(
                                                        child: new Text(location),
                                                        value: location,
                                                      );
                                                    }).toList(),
                                                  ),
                                                  DropdownButton(
                                                    hint: Text('Available Size'), // Not necessary for Option 1
                                                    value: _selectedLocation,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _selectedLocation = newValue;
                                                      });
                                                    },
                                                    items: _locations.map((location) {
                                                      return DropdownMenuItem(
                                                        child: new Text(location),
                                                        value: location,
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 20,left: 70),
                                                  child: Container(
                                                      height: 20,
                                                      width: 50,
                                                      child:Text('\$${users[index].price}',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold
                                                          )
                                                      )
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 20,left: 70),
                                                  child: cart.items.contains(users[index])?Icon(Icons.done,size: 35,):Container(
                                                    alignment: Alignment.center,
                                                    height:30,
                                                    width:70,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFFE7ECEF),
                                                          Colors.white
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
                                                    child: InkWell(
                                                        onTap: (){
                                                          cart.add(users[index]);
                                                        }, child: Text('Add to Cart',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold
                                                      ),)),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },

                                  ),
                                );
                              });
                        }
                        else
                          return Center(child: CircularProgressIndicator(),);
                      },
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }
}





