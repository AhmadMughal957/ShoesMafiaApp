import 'package:cloud_firestore/cloud_firestore.dart';

import 'Catalogmodel2.dart';
import 'View.dart';

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
      FirebaseFirestore.instance.collection('Joggers')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Catalogmodel2.fromJson(doc.data()))
              .toList());
  Stream<List<dynamic>> Sandles()=>
      FirebaseFirestore.instance.collection('Sandles')
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
}