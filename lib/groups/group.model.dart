import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Group {

  final String name;
  final String location;
  final String id;


  Group({this.id, this.name, this.location});

  factory Group.fromDocument(DocumentSnapshot document) {
    return new Group(
      id: document.documentID,
      name: document['name'],
      location: document['location'],
    );
  }

  Map<String, dynamic> toDocument(){

    var result = new Map<String, dynamic>();

    result.putIfAbsent("name", () {return this.name;});
    result.putIfAbsent("location", () {return this.location;});


    return result;
  }

}