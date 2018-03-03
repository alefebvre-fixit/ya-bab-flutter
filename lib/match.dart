import 'package:flutter/material.dart';
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchMaking {
  final String id;
  final String groupId;
  final String ownerId;
  final String date;
  final int players;
  final int games;

  MatchMaking(
      {this.id,
      this.groupId,
      this.ownerId,
      this.date,
      this.players,
      this.games});

  factory MatchMaking.fromDocument(DocumentSnapshot json) {
    return new MatchMaking(
      id: json['id'],
      groupId: json['groupId'],
      ownerId: json['ownerId'],
      date: json['date'],
      players: json['players'],
      games: json['games'],
    );
  }
}

class MatchMakingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Text('displayName');

//    return new StreamBuilder(
//      stream: Firestore.instance.collection('users').snapshots,
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return new Text('Loading...');
//        return new ListView(
//          children: snapshot.data.documents.map((document) {
//            return new Container(
//                padding: new EdgeInsets.all(20.0),
//                child: new Text(document['displayName']));
//          }).toList(),
//        );
//      },
//    );



  }
}
