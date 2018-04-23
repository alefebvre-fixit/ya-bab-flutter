import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/match/player-avatar.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class GameDialog extends StatefulWidget {

  final MatchMaking match;
  final Game game;

  GameDialog(this.match, this.game);

  @override
  GameDialogState createState() => new GameDialogState(this.match, this.game);


}

class GameDialogState extends State<GameDialog> {

  final MatchMaking match;
  final Game game;

  GameDialogState(this.match, this.game);

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
        body: new GameScore(match, game));
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
              new TeamScoreTable(game, match, match.team1),
              new Padding(
                  padding: new EdgeInsets.all(12.0),
                  child: new Text('VS',
                      style: textTheme.headline.copyWith(color: Colors.grey))),
              new TeamScoreTable(game, match, match.team2),
            ],
          ),
        ));


  }

}



class TeamScoreTable extends StatefulWidget {

  TeamScoreTable(this.game, this.match, this.team);

  final MatchMaking match;
  final Team team;
  final Game game;

  @override
  _ScoreTableState createState() => new _ScoreTableState(game, match, team);
}

class _ScoreTableState extends State<TeamScoreTable> {

  final MatchMaking match;
  final Team team;
  final Game game;

  _ScoreTableState(this.game, this.match, this.team);

  void _handleScoreChanged(int newValue) {
    setState(() {
      //score = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {

    int score = game.getScore(team);

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
        //new Text(team.name + ' [' + score.toString() + ']', style: textTheme.title.copyWith(color: team.color)),
        new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                new Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    child:
                    new PlayerAvatar(match, team, team.player1)),
                new Container(
                    margin: const EdgeInsets.only(right: 0.0),
                    child:
                    new PlayerAvatar(match, team, team.player2)),
              ],
            )),




        table,
      ],
    );
  }
}

class ScoreButton extends StatelessWidget {

  final int value;
  final int score;

  ScoreButton({@required this.value, @required this.score, @required this.onChanged})
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




