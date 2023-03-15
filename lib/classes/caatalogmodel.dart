import 'package:flutter/material.dart';
class Catalogmodel{
  var date;
  var time;
  var address;
  List size;
  List colors;
  var phone;
  List name;
  List price;
  Catalogmodel({required this.date,required this.time,required this.name,required this.price, required this.size,required this.address,required this.colors,required this.phone});

  Map<String, dynamic> toJson()=>{
    'date':date,
    'time':time,
    'address':address,
    'phone':phone,
    'size':size,
    'colors':colors,
    'name':name,
    'price':price,
};
  static Catalogmodel fromJson(Map<String, dynamic> json)=>Catalogmodel(
      date: json['date'],
      time: json['time'],
      name: json['name'],
      price: json['price'],
    size:json['size'],
    phone:json['phone'],
    address:json['address'],
      colors:json['colors']
  );
}
