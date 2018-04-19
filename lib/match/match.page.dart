import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/match/match.service.dart';
import 'package:yabab/match/player.dialog.dart';
import 'package:yabab/users/user.model.dart';

class MatchWidget extends StatelessWidget {
  final MatchMaking match;

  MatchWidget(this.match);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        new MatchDetailHeader(match),
        new ExpansionTile(
            title: const Text('Best of 3'),
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
            children: const <Widget>[
              const ListTile(title: const Text('Best of 1')),
              const ListTile(title: const Text('Best of 3')),
              const ListTile(title: const Text('Best of 5')),
            ]),
        //new DetailedScore(),
        new Expanded(child: new GameList(match))

        // new Text("Current number: $_currentValue"),
      ],
    ));
  }
}

class Score extends StatefulWidget {
  final MatchMaking match;

  Score(this.match);

  @override
  _ScoreState createState() => new _ScoreState(this.match);
}

class _ScoreState extends State<Score> {
  final MatchMaking match;

  _ScoreState(this.match);


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
                  child: new PlayerAvatar(match, match.team1, match.team1.player1, (user){
                    setState(() {
                      this.match.team1.player1 = user;
                    });
                  })),
              new Container(
                  margin: const EdgeInsets.only(left: 12.0),
                  child: new PlayerAvatar(match, match.team1, match.team1.player2, (user){
                    setState(() {
                      this.match.team1.player2 = user;
                    });
                  })),            ],
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
                child: new PlayerAvatar(match, match.team2, match.team2.player1, (user){
                  setState(() {
                    this.match.team2.player1 = user;
                  });
                })),            new Container(
                margin: const EdgeInsets.only(right: 26.0),
                child: new PlayerAvatar(match, match.team2, match.team2.player2, (user){
                  setState(() {
                    this.match.team2.player2 = user;
                  });
                })),          ],
        ))
      ],
    );
  }
}

class PlayerAvatar extends StatelessWidget {

  final MatchMaking match;
  final Team team;
  final User user;

  final ValueChanged<User> onChanged;

  PlayerAvatar(this.match, this.team, this.user, this.onChanged);

  @override
  Widget build(BuildContext context) {
    User u;

    var hero;
    if (user != null) {
      hero = new Hero(
        tag: user.id,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(user.avatar),
        ),
      );
    } else {
      hero = new CircleAvatar(
        child: const Text('?'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      );
    }

    return new GestureDetector(
        onTap: () {
          Navigator
              .push(
                  context,
                  new MaterialPageRoute<User>(
                    builder: (BuildContext context) => new PlayerDialog(this.match),
                    fullscreenDialog: true,
                  ))
              .then((user) {
            onChanged(user);
          });
        },
        child: new Container(
            child: hero,
            padding: const EdgeInsets.all(3.0),
            decoration: new BoxDecoration(
              color: team.color, // border color
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
                child: new Score(this.match),
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

class GameList extends StatelessWidget {
  GameList(this.match);

  final MatchMaking match;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: MatchService.instance.instantiateGames(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Game> values = snapshot.data;
    return new ListView.builder(
      itemCount: values != null ? values.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new GameListTile(values[index]),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}

class GameListTile extends StatelessWidget {
  final Game game;

  GameListTile(this.game);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () => {},
      leading: new Hero(
        tag: game.id,
        child: new CircleAvatar(
          child: new Text(game.id),
        ),
      ),
      title: new Text(
        '1' + ':' '2',
        textAlign: TextAlign.center,
        style:
            Theme.of(context).textTheme.headline.copyWith(color: Colors.black),
      ),
    );
  }
}
