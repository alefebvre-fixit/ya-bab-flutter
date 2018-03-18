import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchMakingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MatchMakingList();
  }
}

class MatchMakingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return new Text('displayName');

    return new StreamBuilder(
      stream: Firestore.instance.collection('match-makings').snapshots,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((document) {
            return new Container(
                padding: new EdgeInsets.all(20.0), child: new Text('Hello'));
          }).toList(),
        );
      },
    );
  }
}
