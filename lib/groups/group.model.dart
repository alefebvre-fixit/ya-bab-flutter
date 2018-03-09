import 'package:cloud_firestore/cloud_firestore.dart';

class Group {

  final String name;
  final String id;


  Group({this.id, this.name});

  factory Group.fromDocument(DocumentSnapshot json) {
    return new Group(
      id: json['id'],
      name: json['name'],
    );
  }
}