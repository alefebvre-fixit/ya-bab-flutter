
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/users/user.model.dart';


class UserService {
  UserService._() {}

  static UserService _instance = new UserService._();

  /// Gets the instance of UserService for the default service app.
  static UserService get instance => _instance;



  Stream<QuerySnapshot> findAllAsSnapshot(){
    return Firestore.instance.collection('users').snapshots;
  }

//  Stream<List<User>> findAllUsers(){
//    return Firestore.instance.collection('users').snapshots.map((query) => query.documents).map( (documents) => _fromDocuments(documents.));
//  }
//
//
//  List<User> _fromDocuments(DocumentSnapshot documents){
//
//    documents.
//    //documents.data.map((document) => User.fromDocument(document))
//
//    return [];
//  }



}
