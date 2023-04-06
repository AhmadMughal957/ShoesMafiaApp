import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:foodmafia/Models/App%20images.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ViewModel/Cartmodel.dart';
import '../Models/caatalogmodel.dart';

class Cartpage extends StatefulWidget {
  var email;
   Cartpage({required this.email});

  @override
  State<Cartpage> createState() => _CartpageState(email:email);
}

class _CartpageState extends State<Cartpage> {
  var email;
  var  name=[];
  var price=[];
  TextEditingController phone=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController City=TextEditingController();
  var colors=[];
  var size=[];
  var cdate;
  var tdate;

  _CartpageState({required this.email});
  @override

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        backgroundColor: Colors.white,
        title: Text('Cart-Page',style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontSize: 25
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: scaler.getPaddingLTRB(0, 0, 70, 0),
              child: Text('Checkout',style: TextStyle(
                fontSize: scaler.getTextSize(16)
              ),),
            ),
            Consumer<Cart>(
              builder: (context, cart,child){
                return Padding(
                  padding: scaler.getPaddingLTRB(0, 0, 70, 0),
                  child: Text('${cart.items.length} items  ',style: TextStyle(
                      fontSize: 15
                  ),),
                );
              },
            ),
            Card(
              child: Container(

                height: scaler.getHeight(35),
                width: scaler.getWidth(95),
                child:Consumer<Cart>(builder: (context,cart,child){
                  return ListView.builder(
                    itemCount: cart.items.length,
                      itemBuilder: (context, index ){
                      return Row(
                        children: [
                          Container(
                            decoration:BoxDecoration(

                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                  BoxShadow(
                                    offset: const Offset(-1,0),
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0,0),
                                  )
                                ]
                            ), 
                              height: scaler.getHeight(15),
                            width: scaler.getWidth(25),
                            child: Image.network('${cart.items[index].image}',
                            fit: BoxFit.cover,)
                          ),
                          Padding(
                            padding: scaler.getPaddingLTRB(5, 3, 0, 0),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 100,
                                  child: Text('${cart.items[index].name}')
                                ),
                                Container(
                                  height: 20,
                                  width: 100,
                                  child: DropdownMenuItem(
                                    child: Text('Colour: ${cart.color[index]}')),
                                ),
                                Container(
                                    height: 50,
                                    width: 100,
                                    child: Text('Size: ${cart.size[index]}')
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: scaler.getPaddingLTRB(25, 0, 0, 3),
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: (){
                                    cart.remove(cart.items[index]);
                                  },
                                  child: Icon(Icons.remove_circle,color: Colors.red,),
                                ),
                                Padding(
                                  padding: scaler.getPaddingLTRB(0, 5, 0, 0),
                                  child: Text('\$${cart.items[index].price}'),
                                ),

                              ],
                            ),
                          ),
                        ],
                      );
                      });
                })
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Padding(
                padding: scaler.getPaddingLTRB(2, 0, 85, 0),
                child: Text('City',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: scaler.getPaddingLTRB(2, 0, 20, 0),
              child: Container(
                height: scaler.getHeight(8),
                width: scaler.getWidth(80),
                child: TextFormField(
                  controller: City,
                  decoration:  InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide.none,
                      ),

                      hintStyle: TextStyle(color: Colors.black38,fontFamily: "WorkSansLight"),
                      filled: true,
                      fillColor: Color(0xFFE7ECEF),
                      hintText: 'City/Province'),
                  onChanged: (value) {
                  },
                ),
              ),
            ),
            SizedBox(
              height: scaler.getHeight(3),
            ),
            Container(
              child: Padding(
                padding: scaler.getPaddingLTRB(5, 0, 80, 0),
                child: Text('Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: scaler.getPaddingLTRB(2, 0, 20, 0),
              child: Container(
                height: scaler.getHeight(8),
                width: scaler.getWidth(80),
                child: TextFormField(
                  controller: address,
                  decoration:  InputDecoration(
                      prefixIcon: Icon(
                        Icons.home_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide.none,
                      ),

                      hintStyle: TextStyle(color: Colors.black38,fontFamily: "WorkSansLight"),
                      filled: true,
                      fillColor: Color(0xFFE7ECEF),
                      hintText: 'House no/block/Sector/Town'),
                  onChanged: (value) {
                  },
                ),
              ),
            ),
            SizedBox(
              height: scaler.getHeight(3),
            ),

            Padding(
              padding: scaler.getPaddingLTRB(1, 0, 70, 0),
              child: Text('Phone no   ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: scaler.getPaddingLTRB(2, 0, 20, 0),
              child: Container(
                height: scaler.getHeight(8),
                width: scaler.getWidth(80),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phone,
                  decoration:  InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide.none,
                      ),

                      hintStyle: TextStyle(color: Colors.black38,fontFamily: "WorkSansLight"),
                      filled: true,
                      fillColor: Color(0xFFE7ECEF),
                      hintText: 'Mobile-No'),
                  onChanged: (value) {

                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Container(

                 height: scaler.getHeight(16),
                 width: scaler.getWidth(95),
                 child: Consumer<Cart>(builder: (context,cart,child){
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: scaler.getPaddingLTRB(2, 2, 0, 0),
                         child: Text('SubTotal: ${cart.price}',
                           style:TextStyle(
                               fontSize: scaler.getTextSize(12)
                           ),)),
                       Padding(
                         padding: scaler.getPaddingLTRB(2, 2, 0, 0),
                         child: Text('Delivery-charges: ${5}',
                         style: TextStyle(
                           fontSize: scaler.getTextSize(12)
                         ),),
                       ),if(cart.price>0)...{
                         Padding(
                           padding: scaler.getPaddingLTRB(2, 4, 0, 0),
                           child: Text('Total:                                                           '
                               '\$${cart.price+5}',
                             style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                             ),),
                         ),
                       }
                       else if(cart.price==0)...{
                           Padding(
                             padding: scaler.getPaddingLTRB(2, 4, 0, 0),
                             child: Text('Total:                                                           '
                                 '\$${cart.price}',
                               style: TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold
                               ),),
                           ),
                         }
                     ],
                   );
                 }
               )
               ),
            ),
            Consumer<Cart>(
              builder: (context,cart,child){
                return  Container(
                  height:scaler.getHeight(5),
                  width: scaler.getWidth(40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: Colors.green,

                    ),
                      onPressed: () async{
                        if(address.text.isNotEmpty&&phone.text.isNotEmpty){
                          for(int i=0; i<cart.items.length; i++){
                            if(!name.contains(cart.items[i].name)){
                              name.add(cart.items[i].name);
                              price.add(cart.items[i].price);
                              colors.add(cart.color[i]);
                              size.add(cart.size[i]);
                            }
                            else{
                            }
                          }
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var emaill = prefs.getString('email');
                          email=emaill;
                          cdate=DateFormat("yyyy-MM-dd").format(DateTime.now());
                          tdate=DateFormat("hh:mm:ss a").format(DateTime.now());
                          createUser().then((
                              value) {
                            final snackBar=SnackBar(
                              content:  Text('Order Created Successfully'),
                              backgroundColor: (Colors.black),
                              action: SnackBarAction(
                                label: 'dismiss',
                                onPressed: () {
                                },
                              ),

                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }).onError((error, stackTrace) {
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
                          } );
                        }
                        else{
                          final snackBar=SnackBar(
                            content:  Text('Please Provide Address and Mobile no'),
                            backgroundColor: (Colors.black),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {
                              },
                            ),

                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        },
                      child: Text('Buy Now')),
                );
              },
            ),
            SizedBox(
              height: 10,
            )
  ]
),
      )
                );
}


  Future createUser( ) async{
    final docUser=FirebaseFirestore.instance.collection('orders').doc();

    final user=Catalogmodel(
      city: City.text.toString(),
        email: email,
        time: tdate,
        date: cdate,
        name: name,
        price: price,
        size: size,
        address: address.text.toString(),
        colors: colors,
        phone: phone.text.toString(),
    );
    
    final json=user.toJson();
    await docUser.set(json);
  }
}