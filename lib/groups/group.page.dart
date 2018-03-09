import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/groups/group.model.dart';

final reference = Firestore.instance.collection('groups');

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
            new RaisedButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: new Text("Back to Screen 1"),
            )
          ],
        ),
      ),
    );
  }
}
