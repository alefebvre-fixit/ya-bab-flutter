import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
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
        new GroupDetailHeader(group),
        new Container(
          padding: const EdgeInsets.all(16.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new Text(group.name),
            ),
            new IconButton(icon: new Icon(Icons.favorite), onPressed: () {}),
          ]),
        ),
        new Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: new Text('some tet here')),
      ],
    ));
  }
}

class GroupDetailHeader extends StatelessWidget {
  static const BACKGROUND_IMAGE = 'assets/images/babyfoot.jpg';

  GroupDetailHeader(this.group);

  final Group group;

  @override
  Widget build(BuildContext context) {
    _createPillButton(
      String text, {
      Color backgroundColor = Colors.blueAccent,
      Color textColor = Colors.white,
    }) {
      return new ClipRRect(
        borderRadius: new BorderRadius.circular(30.0),
        child: new MaterialButton(
          minWidth: 140.0,
          color: backgroundColor,
          textColor: textColor,
          onPressed: () {},
          child: new Text(text),
        ),
      );
    }

    var photo = new PhotoHero(
      photo: 'assets/images/babyfoot.jpg',
    );

    return new Stack(
      children: [
        photo,
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: [
              new Text('some tet here')
            ],
          ),
        ),
        new Positioned(
          bottom: 26.0,
          right: 26.0,
          child: _createPillButton(
            'FOLLOW',
            textColor: Colors.white70,
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
}

class ColoredImage extends StatelessWidget {
  ColoredImage(this.image, {@required this.color});

  final Image image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new ClipPath(
      child: new DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: const Alignment(0.0, -1.0),
            end: const Alignment(0.0, 0.6),
            colors: <Color>[color, color.withAlpha(64)],
          ),
        ),
        child: image,
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo}) : super(key: key);

  final String photo;

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Hero(
          tag: photo,
          child: new Material(
            color: Colors.red,
            child: new InkWell(
              child: new ColoredImage(
                new Image.asset(
                  photo,
                  fit: BoxFit.cover,
                ),
                color: Colors.green,
              ),
            ),
          )),
    );
  }
}
