import 'package:flutter/material.dart';
class Catalogmodel2{
  var image;
  List size;
  List color;
  var desc;
  var name;
  var id;
  var price;
  Catalogmodel2({required this.image,required this.desc,required this.name,required this.id,required this.price,required this.size,required this.color
  });

  Map<String, dynamic> toJson()=>{
    'image':image,
    'color':color,
    'size':size,
    'desc':desc,
    'id':id,
    'name':name,
    'price':price,
  };
  static Catalogmodel2 fromJson(Map<String, dynamic> json)=>Catalogmodel2(
    image:json['image'],
    size:json['size'],
    color:json['color'],
    desc:json['desc'],
    id: json['id'],
    name: json['name'],
    price: json['price'],
  );
}
