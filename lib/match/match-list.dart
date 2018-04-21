import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yabab/match/match.page.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/match/match.service.dart';
import 'package:yabab/users/user.model.dart';

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
    return new StreamBuilder(
      stream: MatchService.instance.findAll(),
      builder:
          (BuildContext context, AsyncSnapshot<List<MatchMaking>> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.map((match) {
            return MatchListTile(match);
          }).toList(),
        );
      },
    );
  }
}

class MatchListTile extends StatelessWidget {
  final MatchMaking match;

  MatchListTile(this.match);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      dense: false,
      onTap: () => {},
      leading: new Container(
          child: new Row(
            children: [
              new Container(
                  margin: const EdgeInsets.only(right: 12.0),
                  child: new PlayerAvatar(match, match.team1, match.team1.player1
                      )),
              new Container(
                  margin: const EdgeInsets.only(right: 26.0),
                  child: new PlayerAvatar(match, match.team1, match.team1.player2
                      )),
            ],
          )),
      title: new Text(
        '1' + ':' '2',
        textAlign: TextAlign.center,
        style:
        Theme.of(context).textTheme.headline.copyWith(color: Colors.black),
      ),
      trailing: new Container(
          child: new Row(
            children: [
              new Container(
                  margin: const EdgeInsets.only(right: 12.0),
                  child: new PlayerAvatar(match, match.team2, match.team2.player1
                  )),
              new Container(
                  margin: const EdgeInsets.only(right: 26.0),
                  child: new PlayerAvatar(match, match.team2, match.team2.player2
                  )),
            ],
          )),
    );
  }
}


class PlayerAvatar extends StatelessWidget {
  final MatchMaking match;
  final Team team;
  final User user;

  PlayerAvatar(this.match, this.team, this.user);

  @override
  Widget build(BuildContext context) {

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




Future _createMatch(BuildContext context) async {
  MatchMaking match = await MatchService.instance.instantiateMatch();

  _navigateToMatch(match , context);
}

void _navigateToMatch(MatchMaking match, BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (c) {
        return new MatchWidget(match);
      },
    ),
  );
}
