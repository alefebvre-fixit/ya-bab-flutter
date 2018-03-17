import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/groups/create-group.page.dart';
import 'package:yabab/groups/group.model.dart';
import 'package:yabab/groups/group.page.dart';
import 'package:yabab/groups/group.service.dart';

final reference = Firestore.instance.collection('groups');

enum GroupListACtion { create }

class GroupListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text('some text'),
            actions: <Widget>[
              new PopupMenuButton<GroupListACtion>(
                onSelected: (GroupListACtion value) =>
                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new CreateGroupWidget();
                      },
                    )),
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<GroupListACtion>>[
                      const PopupMenuItem<GroupListACtion>(
                        value: GroupListACtion.create,
                        child: const Text('Create new League'),
                      ),
                    ],
              )
            ]),
        body: new GroupList());
  }
}

class GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: GroupService.instance.findAllAsSnapshot(),
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
            subtitle:
                const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          new Image.asset(
            'assets/images/babyfoot.jpg',
            width: 600.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
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
                        return new GroupWidget(this.group);
                      },
                    ));
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
