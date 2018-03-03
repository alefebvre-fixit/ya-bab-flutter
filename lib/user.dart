import 'package:flutter/material.dart';
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String uid;
  final String displayName;
  final String email;
  final String photoURL;


  User({this.uid, this.displayName, this.email, this.photoURL});

  factory User.fromDocument(DocumentSnapshot json) {
    return new User(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      photoURL: json['photoURL'],
    );
  }
}

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((document) {
            return new Container(
                padding: new EdgeInsets.all(20.0),
                child: new Text(document['displayName'])
            );
          }).toList(),
        );
      },
    );
  }
}

