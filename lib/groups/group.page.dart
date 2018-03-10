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
        body: new Column(
          children: <Widget>[
            new PhotoHero(
              photo: 'assets/images/babyfoot.jpg',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new Row(
                  children: <Widget>[
                    new Flexible(
                      child: new Text(group.name),
                    ),
                    new IconButton(
                      icon: new Icon(Icons.favorite),
                      onPressed: () {}
                    ),

                  ]
              ),
            ),
            new Container(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: new Text('some tet here')
            ),
          ],
        )
    );


  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Hero(
          tag: photo,
          child: new Material(
            color: Colors.transparent,
            child: new InkWell(
              onTap: onTap,
              child: new Image.asset(
                photo,
                fit: BoxFit.cover,
              ),
            ),
          )
      ),
    );
  }
}