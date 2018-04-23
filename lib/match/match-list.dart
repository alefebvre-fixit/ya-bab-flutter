import 'dart:async';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:yabab/match/match.page.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/match/match.service.dart';
import 'package:yabab/match/player-avatar.dart';


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
            return new Container(
              padding: new EdgeInsets.all(10.0),
              child: new MatchCard(match),
            );
          }).toList(),
        );
      },
    );
  }
}

class MatchCard extends StatelessWidget {
  final MatchMaking match;

  MatchCard(this.match);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: const Icon(CommunityMaterialIcons.soccer_field),
            title: new Text('League Name'),
            subtitle: new Text('@' + 'League Location'),
          ),
          new Score(match),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('OPEN'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                  child: new PlayerAvatar(
                      match, match.team1, match.team1.player1)),
              new Container(
                  margin: const EdgeInsets.only(left: 12.0),
                  child: new PlayerAvatar(
                      match, match.team1, match.team1.player2)),
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
                .copyWith(color: Colors.lightGreen),
          ),
        )),
        new Container(
            child: new Row(
          children: [
            new Container(
                margin: const EdgeInsets.only(right: 12.0),
                child:
                    new PlayerAvatar(match, match.team2, match.team2.player1)),
            new Container(
                margin: const EdgeInsets.only(right: 26.0),
                child:
                    new PlayerAvatar(match, match.team2, match.team2.player2)),
          ],
        ))
      ],
    );
  }
}

Future _createMatch(BuildContext context) async {
  MatchMaking match = await MatchService.instance.instantiateMatch();

  _navigateToMatch(match, context);
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
