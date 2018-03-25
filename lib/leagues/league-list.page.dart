import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/leagues/league.model.dart';
import 'package:yabab/leagues/league.page.dart';
import 'package:yabab/leagues/league.service.dart';

final reference = Firestore.instance.collection('leagues');

class LeagueListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new LeagueList();
  }
}

class LeagueList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: LeagueService.instance.findAll(),
      builder: (BuildContext context, AsyncSnapshot<List<League>> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.map((league) {
            return new Container(
                padding: new EdgeInsets.all(20.0),
                child: new LeagueCard(league),
            );
          }).toList(),
        );
      },
    );
  }
}

class LeagueCard extends StatelessWidget {
  final League league;

  LeagueCard(this.league);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: const Icon(CommunityMaterialIcons.trophy),
            title: new Text(league.name),
            subtitle: new Text('@' + league.location),
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
                  child: const Text('OPEN'),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new LeagueWidget(this.league);
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

class LeagueListTile extends StatelessWidget {
  final League league;

  LeagueListTile(this.league);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(this.league.name),
      subtitle: new Text(this.league.name + "-from obj"),
    );
  }
}
