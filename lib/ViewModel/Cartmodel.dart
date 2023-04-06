import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/Catalogmodel2.dart';
import '../Models/caatalogmodel.dart';
class Cart with ChangeNotifier {
  bool pressed=false;
   var email;
   var size=[];
   var color=[];
  List  items=[];
  double price=0.0;

   void add2(String item){

     size.add(item);
     notifyListeners();
   }
  void add3(String item){

    color.add(item);
    notifyListeners();
  }

  void add(Catalogmodel2 item,){
    items.add(item);
    price=price+item.price;
    notifyListeners();
  }
  int get count {
    return items.length;
  }
  void remove(Catalogmodel2 item){
    price=price-item.price;
    items.remove(item);
    notifyListeners();
  }

}