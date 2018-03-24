
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/users/user.model.dart';


class UserService {
  UserService._();

  static UserService _instance = new UserService._();

  /// Gets the instance of UserService for the default service app.
  static UserService get instance => _instance;


  Future<User> findOne(String id) {
    return Firestore.instance
        .collection('users')
        .document(id)
        .get()
        .then((document) => new User.fromDocument(document));
  }

  Stream<QuerySnapshot> findAllAsSnapshot(){
    return Firestore.instance.collection('users').snapshots;
  }

  Stream<List<User>> findAllUsers(){
    return Firestore.instance.collection('users').snapshots.map((query) => query.documents).map( (documents) => _fromDocuments(documents));
  }


  List<User> _fromDocuments(List<DocumentSnapshot> documents){
    return documents.map((document) => new User.fromDocument(document)).toList();
  }

//  List<User> _fromIds(List<String> ids){
//    return ids.map((id) => findOne(id)).toList();
//  }





}
