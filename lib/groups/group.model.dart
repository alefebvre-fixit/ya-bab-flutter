import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Group {

  String name;
  String location;

  String id;


  Group({this.id, this.name, this.location});

  factory Group.fromDocument(DocumentSnapshot json) {
    return new Group(
      id: json['id'],
      name: json['name'],
      location: json['location'],

    );
  }

  Map<String, dynamic> toDocument(){

    var result = new Map<String, dynamic>();

    result.putIfAbsent("id", () {return this.id;});
    result.putIfAbsent("name", () {return this.name;});
    result.putIfAbsent("location", () {return this.location;});


    return result;
  }

}