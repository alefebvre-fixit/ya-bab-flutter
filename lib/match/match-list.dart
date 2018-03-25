import 'package:flutter/material.dart';
import 'package:yabab/match/match.page.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/match/match.service.dart';

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
                padding: new EdgeInsets.all(20.0), child: new Text('Hello'));
          }).toList(),
        );
      },
    );
  }
}

void _createMatch(BuildContext context) {
  _navigateToMatch(new MatchMaking(), context);
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
