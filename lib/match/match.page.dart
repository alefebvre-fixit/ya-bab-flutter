import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yabab/match/match.model.dart';
import 'package:numberpicker/numberpicker.dart';

class MatchWidget extends StatelessWidget {
  final MatchMaking match;

  MatchWidget(this.match);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        new MatchDetailHeader(match),
        new Container(
          padding: const EdgeInsets.all(16.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new Text('league name'),
            ),
            new IconButton(icon: new Icon(Icons.favorite), onPressed: () {}),
          ]),
        ),


        new NumberPicker.integer(
            initialValue: 0,
            minValue: 0,
            maxValue: 100,
            onChanged: (newValue) {},)
       // new Text("Current number: $_currentValue"),
      ],
    ));
  }
}

class Score extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Row(children: [
          new Container(
              child: new Row(
            children: [
              new Container(
                  margin: const EdgeInsets.only(left: 26.0),
                  child: new PlayerAvatar(Colors.blue)),
              new Container(
                  margin: const EdgeInsets.only(left: 12.0),
                  child: new PlayerAvatar(Colors.blue)),
            ],
          ))
        ]),
        new Expanded(
            child: new Container(
          child: new Text(
            '1' + ':' '2',
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.white),
          ),
        )),
        new Container(
            child: new Row(
          children: [
            new Container(
                margin: const EdgeInsets.only(right: 12.0),
                child: new PlayerAvatar(Colors.red)),
            new Container(
                margin: const EdgeInsets.only(right: 26.0),
                child: new PlayerAvatar(Colors.red)),
          ],
        ))
      ],
    );
  }
}

class PlayerAvatar extends StatelessWidget {
  final Color color;

  PlayerAvatar(this.color);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          print('Tap!');
        },
        child: new Container(
            child: new CircleAvatar(
                child: const Text('?'),
                foregroundColor: Colors.white,
                backgroundColor: Colors.green),
            padding: const EdgeInsets.all(3.0),
            decoration: new BoxDecoration(
              color: color, // border color
              shape: BoxShape.circle,
            )));
  }
}

class MatchDetailHeader extends StatelessWidget {
  static const BACKGROUND_IMAGE = 'assets/images/babyfoot.jpg';

  MatchDetailHeader(this.match);

  final MatchMaking match;

  @override
  Widget build(BuildContext context) {
    var photo = new PhotoHero(
      photo: BACKGROUND_IMAGE,
    );

    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var title = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Text(
          'league name',
          style: textTheme.display1.copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: new Text(
            'hello',
            style: textTheme.headline.copyWith(color: Colors.white),
          ),
        ),
      ],
    );

    return new Stack(
      children: [
        photo,
        new AppBar(
          toolbarOpacity: 0.9,
          bottomOpacity: 0.0,
          backgroundColor: Colors.green.withAlpha(0),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.create),
              tooltip: 'Edit',
              onPressed: () {},
            )
          ],
        ),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: [
              new Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: title,
              ),
              new Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: new Score(),
              ),
            ],
          ),
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
            colors: <Color>[color.withAlpha(198), color.withAlpha(210)],
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
