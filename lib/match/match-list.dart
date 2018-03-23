import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/match/match.page.dart';
import 'package:yabab/match/match.model.dart';

class MatchMakingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new Scaffold(
      body: new Center(
        child: new MatchMakingList(),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: new Icon(Icons.add),
        onPressed: () => _createMatch(context),
      ),
    );
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

_createMatch(BuildContext context) {
  _navigateToMatch(new MatchMaking(), context);
}

_navigateToMatch(MatchMaking match, BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (c) {
        return new MatchWidget(match);
      },
    ),
  );
}
