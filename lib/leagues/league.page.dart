import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yabab/leagues/create-league.page.dart';
import 'package:yabab/leagues/league-follow.button.dart';
import 'package:yabab/leagues/league.model.dart';
import 'package:yabab/leagues/league.service.dart';
import 'package:yabab/users/user.model.dart';
import 'package:yabab/users/user.page.dart';
import 'package:yabab/users/user.tile.dart';

class LeagueWidget extends StatelessWidget {
  final League league;

  LeagueWidget(this.league);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        new LeagueDetailHeader(league),
        new Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: new Text('some text here')),
        new Expanded(child: new FollowerList(league))
      ],
    ));
  }
}

class LeagueDetailHeader extends StatelessWidget {
  static const BACKGROUND_IMAGE = 'assets/images/babyfoot.jpg';

  LeagueDetailHeader(this.league);

  final League league;

  @override
  Widget build(BuildContext context) {
    var photo = new PhotoHero(
      photo: BACKGROUND_IMAGE,
    );

    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var locationInfo = new Row(
      children: [
        new Icon(
          Icons.place,
          color: Colors.white,
          size: 16.0,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            league.location,
            style: textTheme.subhead.copyWith(color: Colors.white),
          ),
        ),
      ],
    );

    var title = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          league.name,
          style: textTheme.display1.copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: locationInfo,
        ),
      ],
    );

    return new Stack(
      children: [
        photo,
        new AppBar(
          toolbarOpacity: 0.9,
          bottomOpacity: 0.0,
          backgroundColor: Colors.red.withAlpha(0),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.create),
              tooltip: 'Edit',
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return new CreateLeagueWidget(league);
                  },
                ));
              },
            )
          ],
        ),
        new Positioned(bottom: 70.0, left: 26.0, child: title),
        new Positioned(
            bottom: 26.0, right: 26.0, child: new LeagueFollowButton(league))
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
            colors: <Color>[color.withAlpha(100), color.withAlpha(64)],
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
                color: Colors.black,
              ),
            ),
          )),
    );
  }
}

class FollowerList extends StatelessWidget {
  FollowerList(this.league);

  final League league;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: LeagueService.instance.findAllFollowers(league.id),
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
    List<User> values = snapshot.data;
    return new ListView.builder(
      itemCount: values!= null ? values.length: 0,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new UserListTile(values[index], () => _navigateToUserDetails(values[index], context)),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}



void _navigateToUserDetails(User user, BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (c) {
        return new UserDetailsPage(user);
      },
    ),
  );
}
