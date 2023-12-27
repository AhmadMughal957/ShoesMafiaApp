import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/View/Details_Screens/Bootsdetails.dart';
import 'package:foodmafia/Models/GetData.dart';

import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'Detailpage.dart';
import '../../ViewModel/Cartmodel.dart';
import '../../Models/Catalogmodel2.dart';
import '../../ViewModel/View.dart';
import '../../Models/caatalogmodel.dart';
import '../cartpage.dart';
import '../../Models/App images.dart';

class Boots extends StatefulWidget {
  var email;
  Boots({required this.email });

  @override
  State<Boots> createState() => _BootsState(email:email);
}

class _BootsState extends State<Boots> {
  var email;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  var price = 0;
  final auth=FirebaseAuth.instance;
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String? _selectedLocation;
  int count=0;
  var list;
  bool check=false;
  var Colour=[];
  var Size=[];

  _BootsState({required this.email});
  @override
  Widget build(BuildContext context) {

    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      appBar: AppBar(
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
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        backgroundColor: Colors.white,
        title: Text('Boots',style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontSize: 25
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                  return check?
                  Container(
                    height: scaler.getHeight(90),
                    width: scaler.getWidth(100),
                    child: StreamBuilder(
                      stream: GetData().Boots(),
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
                                    Colour=users[index].color;
                                    Size=users[index].size;
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Bootsdetails(
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
                                                height: scaler.getHeight(19),
                                                width: scaler.getWidth(30),
                                                child: CachedNetworkImage(
                                                  imageUrl: '${users[index].image}',
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                          fit:BoxFit.fill
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) => CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                ),
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
                                                    height: scaler.getHeight(8),
                                                    width: scaler.getWidth(30),
                                                    child: Text('${users[index].name}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold)
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 25,right: 60),
                                                    child: Container(
                                                      height: scaler.getHeight(8),
                                                      width: scaler.getWidth(18),
                                                      child: Text('\$${users[index].price}',
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              fontWeight: FontWeight.w300
                                                          )
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:scaler.getPaddingLTRB(20,0, 0, 0),
                                              child: Icon(Icons.arrow_forward_ios_sharp),
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
                  ):
                  Container(

                    height: scaler.getHeight(90),
                    width: scaler.getWidth(100),
                    child: StreamBuilder(
                      stream: GetData().Boots(),
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
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Bootsdetails(
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
                                              color: Colors.grey.shade600,
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 5),
                                            ),

                                          ]
                                      ),

                                      child: Column(
                                        children: [
                                          Card(
                                            child: Container(
                                              height: scaler.getHeight(16),
                                              width: scaler.getWidth(40),
                                              child: CachedNetworkImage(
                                                imageUrl: '${users[index].image}',
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) => CircularProgressIndicator(),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                              ),
                                              decoration:BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade600,
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 5),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: scaler.getHeight(4.5),
                                              width: scaler.getWidth(40),
                                              child: Text('\$${users[index].price}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17
                                                ),
                                              ),

                                            ),
                                          )
                                        ],
                                      ),
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
                  );
                }),

          ],
        ),
      ),
    );
  }
}





