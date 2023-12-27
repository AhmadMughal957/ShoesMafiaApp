import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/View/cartpage.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/Cartmodel.dart';
import '../../Models/GetData.dart';
import 'package:badges/badges.dart' as badges;
class Bootsdetails extends StatefulWidget {
  var index;
  var image;
  var name;
  var price;
  var desc;
  var size=[];
  var colors=[];
  Bootsdetails ({required this.index,required this.name,required this.price,required this.desc,required this.size,required this.colors,required this.image});

  @override
  State<Bootsdetails> createState() => _BootsdetailsState(name:name,price:price,desc: desc,size:size,colors: colors,image: image,index:index);
}

class _BootsdetailsState extends State<Bootsdetails> {

  String? selectedLocation;
  String? _selectedLocation2;
  var index;
  var image;
  var name;
  int price;
  var desc;
  var size=[];
  var colors=[];

  _BootsdetailsState({required this.name,required this.price,required this.desc,required this.size,required this.colors,required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    print(size);
    ScreenScaler scaler = ScreenScaler()..init(context);
    List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
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
        backgroundColor: Colors.white,
        title: Text('${name}',style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontSize: 25
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            InkWell(
              onTap: (){
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: SingleChildScrollView(
                        child: Container(
                          height: scaler.getHeight(40),
                          width: scaler.getWidth(50),
                          child: CachedNetworkImage(
                            imageUrl: '${image}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: scaler.getHeight(60),
                width: scaler.getWidth(99),
                child: CachedNetworkImage(
                  imageUrl: '${image}',
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
              ),
            ),
            Card(
              child: Container(
                  height: scaler.getHeight(50),
                  width: scaler.getWidth(99),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: scaler.getPaddingLTRB(5, 1, 0, 0),
                            child: Container(
                              height: scaler.getHeight(10),
                              width: scaler.getWidth(50),
                              child: Text('${name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                ),),
                            ),
                          ),

                          Padding(
                            padding: scaler.getPaddingLTRB(23, 1, 0, 6.5),
                            child: Container(
                              height: scaler.getHeight(3),
                              width: scaler.getWidth(20),
                              child: Text('\$${price}',
                                style: TextStyle(

                                    fontSize: 25
                                ),),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: scaler.getPaddingLTRB(2, 1, 0, 0),
                        alignment: Alignment.topLeft,
                        color: Colors.grey.shade50,
                        height: scaler.getHeight(15),
                        width: scaler.getWidth(90),
                        child: Text('${desc}',style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                            fontSize: 20
                        ),),
                      ),
                      SizedBox(
                        height: scaler.getHeight(2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 200,top: 0),
                        child: Container(
                          height: 50,
                          width: 150,
                          child:   DropdownButton(
                            hint: Text('Available Color'), // Not necessary for Option 1
                            value: selectedLocation,
                            onChanged: (newValue) {
                              setState(() {
                                selectedLocation = newValue as String?;
                              });
                            },
                            items: colors.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 200,),
                        child: Container(
                          height: 50,
                          width: 150,
                          child: DropdownButton(
                            hint: Text('Available Size'), // Not necessary for Option 1
                            value: _selectedLocation2,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedLocation2 = newValue as String?;
                              });
                            },
                            items: size.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: StreamBuilder(
                          stream: GetData().Boots(),
                          builder: (context ,snapshot){
                            if(snapshot.hasData){
                              final users=snapshot.data!;
                              return Consumer<Cart>(
                                builder: (context, cart,child){
                                  return cart.items.contains(users[index])?Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFE7ECEF),
                                          shape: BoxShape.circle
                                      ),
                                      child: Icon(Icons.done_outline_sharp,size: 35,)):InkWell(
                                    onTap: (){
                                      print(users[index].name);
                                      cart.pressed=true;
                                      cart.add2(_selectedLocation2!);
                                      cart.add3(selectedLocation!);
                                      cart.add(users[index]);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height:50,
                                      width:250,
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
                                      child: Text('Add to Cart',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ),
                                  );
                                },
                              );
                            }
                            else return Text('');
                          },

                        ),
                      ),

                    ],
                  )

              ),
            ),

          ],
        ),
      ),
    );
  }
}
