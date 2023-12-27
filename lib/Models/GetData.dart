import 'package:cloud_firestore/cloud_firestore.dart';

import 'Catalogmodel2.dart';
import '../ViewModel/View.dart';
import '../ViewModel/Viewmodel.dart';

class GetData{
  Stream<List<dynamic>> Sneakers()=>
      FirebaseFirestore.instance.collection('Sneakers')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Catalogmodel2.fromJson(doc.data()))
              .toList());
  Stream<List<dynamic>> Loafers()=>
      FirebaseFirestore.instance.collection('Loafers')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Catalogmodel2.fromJson(doc.data()))
              .toList());
  Stream<List<dynamic>> Boots()=>
      FirebaseFirestore.instance.collection('Boots')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Catalogmodel2.fromJson(doc.data()))
              .toList());
  Stream<List<dynamic>> Joggers()=>
      FirebaseFirestore.instance.collection('Jogers')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Catalogmodel2.fromJson(doc.data()))
              .toList());
  Stream<List<dynamic>> Sandles()=>
      FirebaseFirestore.instance.collection('sandles')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Catalogmodel2.fromJson(doc.data()))
              .toList());

  Stream<List<dynamic>> readUser3()=>
      FirebaseFirestore.instance.collection('View')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Vieww.fromJson(doc.data()))
              .toList());
  Stream<List<Viewmodel>> View1()=>FirebaseFirestore.instance.collection('Heading1')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc)=>Viewmodel.fromJson(doc.data())).toList());
  Stream<List<Viewmodel>> View2()=>FirebaseFirestore.instance.collection('Heading2')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc)=>Viewmodel.fromJson(doc.data())).toList());
  Stream<List<Viewmodel>> View3()=>FirebaseFirestore.instance.collection('Heading3')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc)=>Viewmodel.fromJson(doc.data())).toList());
  Stream<List<Viewmodel>> View4()=>FirebaseFirestore.instance.collection('Heading4')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc)=>Viewmodel.fromJson(doc.data())).toList());
  Stream<List<Viewmodel>> View5()=>FirebaseFirestore.instance.collection('Heading5')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc)=>Viewmodel.fromJson(doc.data())).toList());
}