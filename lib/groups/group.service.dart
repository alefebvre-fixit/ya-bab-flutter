
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/groups/group.model.dart';
import 'package:yabab/users/user.model.dart';


class GroupService {
  GroupService._() {}

  static GroupService _instance = new GroupService._();

  /// Gets the instance of UserService for the default service app.
  static GroupService get instance => _instance;



  Stream<QuerySnapshot> findAllAsSnapshot(){
    return Firestore.instance.collection('groups').snapshots;
  }

  Future<void> upsert(Group group){

    return Firestore.instance.collection('groups').document().setData(group.toDocument());

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
