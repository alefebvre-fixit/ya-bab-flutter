import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yabab/match/match.model.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class FullScreenDialogDemo extends StatefulWidget {
  @override
  FullScreenDialogDemoState createState() => new FullScreenDialogDemoState();
}

class FullScreenDialogDemoState extends State<FullScreenDialogDemo> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Scaffold(
        appBar: new AppBar(title: const Text('Match Score'), actions: <Widget>[
          new FlatButton(
              child: new Text('SAVE',
                  style: theme.textTheme.body1.copyWith(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context, DismissDialogAction.save);
              })
        ]),
        body: new GameScore(new MatchMaking(), new Game(id: "1", scoreTeamA: 0, scoreTeamB: 0)));
  }
}











class GameScore extends StatefulWidget {


  final MatchMaking match;
  final Game game;

  GameScore(this.match, this.game);


  @override
  _GameScoreState createState() => new _GameScoreState(match, game);

}

class _GameScoreState extends State<GameScore> {

  final MatchMaking match;
  final Game game;

  _GameScoreState(this.match, this.game);

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Container(
        child: new Padding(
          padding: new EdgeInsets.all(12.0),
          child: new Column(
            children: <Widget>[
              new Text('Game #' + game.id,
                  style: textTheme.headline.copyWith(color: Colors.green)),
              new TeamScoreTable('Blue Team', Colors.blue),
              new Padding(
                  padding: new EdgeInsets.all(12.0),
                  child: new Text('VS',
                      style: textTheme.headline.copyWith(color: Colors.grey))),
              new TeamScoreTable('Red Team', Colors.red),
            ],
          ),
        ));


  }

}



class TeamScoreTable extends StatefulWidget {

  TeamScoreTable(this.name, this.color);

  final String name;
  final Color color;

  @override
  _ScoreTableState createState() => new _ScoreTableState(name, color);
}

class _ScoreTableState extends State<TeamScoreTable> {

  int score = 99;
  final String name;
  final Color color;

  _ScoreTableState(this.name, this.color);


  void _handleScoreChanged(int newValue) {
    setState(() {
      score = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var table = new Table(
        columnWidths: const <int, TableColumnWidth>{},
        children: <TableRow>[
          new TableRow(children: <Widget>[
            new ScoreButton(value: 0, score: score, onChanged: _handleScoreChanged),
            new ScoreButton(value: 1, score: score, onChanged: _handleScoreChanged),
            new ScoreButton(value: 2, score: score, onChanged: _handleScoreChanged),
            new ScoreButton(value: 3, score: score, onChanged: _handleScoreChanged),
            new ScoreButton(value: 4, score: score, onChanged: _handleScoreChanged),
          ]),
          new TableRow(children: <Widget>[
            new ScoreButton(value: 5, score: score, onChanged: _handleScoreChanged),
            new ScoreButton(value: 6, score: score, onChanged: _handleScoreChanged),
            new ScoreButton(value: 7, score: score, onChanged: _handleScoreChanged),
            new ScoreButton(value: 8, score: score, onChanged: _handleScoreChanged),
            new ScoreButton(value: 9, score: score, onChanged: _handleScoreChanged),
          ]),
        ]);

    return new Column(
      children: <Widget>[
        new Text(name + ' [' + score.toString() + ']', style: textTheme.title.copyWith(color: color)),
        table,
      ],
    );
  }
}

class ScoreButton extends StatelessWidget {

  final int value;
  final int score;

  ScoreButton({@required this.value: 0, @required this.score, @required this.onChanged})
      : super();

  final ValueChanged<int> onChanged;

  void onPressed() {
    onChanged(value);
  }


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var button = new FlatButton(
        color: this.score == this.value ? Colors.green.shade100 : Colors.white10,
        onPressed: this.onPressed,
        shape: new CircleBorder(
          side: new BorderSide(width: 2.0, color: Colors.green.shade200),
        ),
        padding: new EdgeInsets.all(16.0),
        child: new Text(this.value.toString(),
            style: textTheme.headline.copyWith(color: Colors.green)));



    return new TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: new Padding(
            padding: new EdgeInsets.all(6.0), child: button));

  }

}




