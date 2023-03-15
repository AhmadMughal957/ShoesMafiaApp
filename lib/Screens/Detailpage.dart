import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/Cartmodel.dart';
import '../classes/GetData.dart';
class Detail extends StatefulWidget {
  var index;
  var image;
  var name;
  var price;
  var desc;
  var size=[];
  var colors=[];
  Detail ({required this.index,required this.name,required this.price,required this.desc,required this.size,required this.colors,required this.image});

  @override
  State<Detail> createState() => _DetailState(name:name,price:price,desc: desc,size:size,colors: colors,image: image,index:index);
}

class _DetailState extends State<Detail> {

  String? selectedLocation;
  String? _selectedLocation2;
  var index;
  var image;
  var name;
  int price;
  var desc;
  var size=[];
  var colors=[];

  _DetailState({required this.name,required this.price,required this.desc,required this.size,required this.colors,required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
    String? _selectedLocation;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 420,
            width: 400,
            child: CachedNetworkImage(
              imageUrl: '${image}',
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
          ),
          Card(
            child: Container(
              height: 390,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25,top: 40),
                        child: Container(
                          height: 50,
                          width: 120,
                          child: Text('${name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 140,top: 40),
                        child: Container(
                          height: 50,
                          width: 100,
                          child: Text('\$${price}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            ),),
                        ),
                      ),
                      ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    color: Color(0xFFE7ECEF),
                    height: 100,
                    width: 300,
                    child: Text('${desc}'),
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
                    padding: const EdgeInsets.only(top: 40),
                    child: StreamBuilder(
                      stream: GetData().Sneakers(),
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
    );
  }
}
