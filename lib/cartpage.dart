import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodmafia/classes/App%20images.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'classes/Cartmodel.dart';
import 'classes/caatalogmodel.dart';

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
  var colors=[];
  var size=[];
  var cdate;
  var tdate;

  _CartpageState({required this.email});
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,  
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 280,top: 20),
              child: Text('Checkout',style: TextStyle(
                fontSize: 30
              ),),
            ),
            Consumer<Cart>(
              builder: (context, cart,child){
                return Padding(
                  padding: const EdgeInsets.only(right: 280),
                  child: Text('${cart.items.length} items  ',style: TextStyle(
                      fontSize: 15
                  ),),
                );
              },
            ),
            Card(
              child: Container(
                height: 300,
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
                                    color: Colors.white,
                                    offset: const Offset(-5,0),
                                  ),
                                  BoxShadow(

                                    offset: const Offset(0,0),
                                  )
                                ]
                            ),
                            height: 100,
                            width: 100,
                            child: Image.network('${cart.items[index].image}',
                            fit: BoxFit.cover,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20,top: 20),
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
                            padding: const EdgeInsets.only(left:110,bottom: 40),
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: (){
                                    cart.remove(cart.items[index]);
                                  },
                                  child: Icon(Icons.remove_circle,color: Colors.red,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:20),
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
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 330),
              child: Text('Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
            ),
            TextFormField(
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 310),
              child: Text('Phone no   ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
            ),
            TextFormField(
              controller: phone,
              decoration:  InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,
                  ),

                  hintStyle: TextStyle(color: Colors.black38,fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Color(0xFFE7ECEF),
                  hintText: 'Mobile-Number'),
              onChanged: (value) {

              },
            ),
            Card(
              child: Container(
                 height: 100,
                 width: 380,
                 child: Consumer<Cart>(builder: (context,cart,child){
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 5,left: 6),
                         child: Text('SubTotal                                                                                           '
                             '\$${cart.price}'),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top:50,left: 5),
                         child: Text('Total                                                              '
                             '\$${cart.price}',
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold
                         ),),
                       ),
                     ],
                   );
                 }
               )
               ),
            ),
            Consumer<Cart>(
              builder: (context,cart,child){
                return  ElevatedButton(
                    onPressed: (){
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
                        cdate=DateFormat("yyyy-MM-dd").format(DateTime.now());
                        tdate=DateFormat("hh:mm:ss a").format(DateTime.now());
                        email=Cart().email;
                        createUser(name ,price,address.text.toString(),phone.text.toString(),cdate,tdate).then((
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
                    child: Text('Buy Now'));
              },
            )
  ]
),
      )
                );
}


  Future createUser( final name, final price, var address, var phone,var date,var time) async{
    final docUser=FirebaseFirestore.instance.collection('orders').doc();

    final user=Catalogmodel(
        time: time,
        date: date,
        name: name,
        price: price,
        size: size,
        address: address,
        colors: colors,
        phone: phone,
    );
    
    final json=user.toJson();
    await docUser.set(json);
  }
}