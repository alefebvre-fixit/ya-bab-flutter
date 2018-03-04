import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // new
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:cloud_firestore/cloud_firestore.dart';

final googleSignIn = new GoogleSignIn();
final auth = FirebaseAuth.instance; // new

final reference = Firestore.instance.collection('groups');


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

class GroupListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('groups').snapshots,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((document) {
            return new Container(
                padding: new EdgeInsets.all(20.0),
                child: new GroupCard(new Group.fromDocument(document)));
          }).toList(),
        );
      },
    );
  }
}

class GroupWidget extends StatelessWidget {

  Group group;

  GroupWidget(Group group) {
    this.group = group;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Group" + group.name),
      ),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(onPressed: () {
              Navigator.of(context).pop(null);
            }, child: new Text("Back to Screen 1"),)
          ],
        ),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {

  Group group;

  GroupCard(Group group) {
    this.group = group;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.recent_actors),
            title: new Text(group.name),
            subtitle: const Text(
                'Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          new Image.asset(
            'assets/images/babyfoot.jpg',
            width: 600.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),






    new ButtonTheme
              .bar( // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                new FlatButton(
                  child: const Text('OPEN'),
                  onPressed: () {

                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new GroupWidget(
                          this.group
                        );
                      },
                    ));

                    /* ... */
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class GroupListTile extends StatelessWidget {

  Group group;

  GroupListTile(Group group) {
    this.group = group;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(this.group.name),
      subtitle: new Text(this.group.name + "-from obj"),
    );
  }
}
