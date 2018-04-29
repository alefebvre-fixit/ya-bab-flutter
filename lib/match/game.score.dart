import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/match/player-avatar.dart';

class GameScore extends StatefulWidget {

  final MatchMaking match;
  final Game game;
  final Function onScoreSet;

  GameScore({@required this.match, @required this.game, this.onScoreSet});

  @override
  _GameScoreState createState() => new _GameScoreState(match: match, game: game, onScoreSet: onScoreSet);
}

class _GameScoreState extends State<GameScore> {

  final MatchMaking match;
  final Game game;
  final Function onScoreSet;

  void _handleScoreChanged(Team team, int newValue) {
    setState(() {
      if (this.game.getScore(team) == newValue) {
        this.game.setScore(team, null);
      } else {
        this.game.setScore(team, newValue);
      }

      this.match.calculateScore();

      if (game.isScoreSet()){
        this.onScoreSet();
      }
    });
  }

  _GameScoreState({@required this.match, @required this.game, this.onScoreSet});

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
          new TeamScoreTable(game, match, match.team1, (newValue) {
            _handleScoreChanged(match.team1, newValue);
          }),
          new Padding(
              padding: new EdgeInsets.all(12.0),
              child: new Text('VS',
                  style: textTheme.headline.copyWith(color: Colors.grey))),
          new TeamScoreTable(game, match, match.team2, (newValue) {
            _handleScoreChanged(match.team2, newValue);
          }),
        ],
      ),
    ));
  }
}

class TeamScoreTable extends StatelessWidget {
  TeamScoreTable(this.game, this.match, this.team, this.onChanged);

  final MatchMaking match;
  final Team team;
  final Game game;
  final ValueChanged<int> onChanged;

  _buildScoreCell(int value, bool readOnly) {
    int score = game.getScore(team);

    return new TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: new Padding(
            padding: new EdgeInsets.all(6.0),
            child: new ScoreButton(
                value: value,
                score: score,
                onChanged: onChanged,
                readOnly: readOnly)));
  }

  _buildTable(bool readOnly) {
    return new Table(
        columnWidths: const <int, TableColumnWidth>{},
        children: <TableRow>[
          new TableRow(children: <Widget>[
            _buildScoreCell(0, readOnly),
            _buildScoreCell(1, readOnly),
            _buildScoreCell(2, readOnly),
            _buildScoreCell(3, readOnly),
            _buildScoreCell(4, readOnly),
          ]),
          new TableRow(children: <Widget>[
            _buildScoreCell(5, readOnly),
            _buildScoreCell(6, readOnly),
            _buildScoreCell(7, readOnly),
            _buildScoreCell(8, readOnly),
            _buildScoreCell(9, readOnly),
          ]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    int score = game.getScore(team);
    int oppositeScore = game.getOppositeScore(team);

    var stack;
    if (score == 10 || (score == null && oppositeScore != 10)) {
      stack = new Stack(alignment: Alignment.center, children: [
        new Opacity(
          opacity: 0.1,
          child: _buildTable(true),
        ),
        new ScoreButton(
            size: 60.0, value: 10, score: score, onChanged: onChanged)
      ]);
    } else {
      stack = new Stack(alignment: Alignment.center, children: [
        new Opacity(
          opacity: 0.1,
          child: new ScoreButton(
              size: 60.0,
              value: 10,
              score: score,
              onChanged: onChanged,
              readOnly: true),
        ),
        _buildTable(false)
      ]);
    }

    var column = new Column(
      children: <Widget>[
        //new Text(team.name + ' [' + score.toString() + ']', style: textTheme.title.copyWith(color: team.color)),
        new Container(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
                margin: const EdgeInsets.only(right: 12.0),
                child: new PlayerAvatar(match, team, team.player1)),
            new Container(
                margin: const EdgeInsets.only(right: 0.0),
                child: new PlayerAvatar(match, team, team.player2)),
          ],
        )),
        stack,
      ],
    );

    return column;
  }
}

class ScoreButton extends StatelessWidget {
  final bool readOnly;
  final int value;
  final int score;
  final double size;

  ScoreButton(
      {@required this.value,
      @required this.score,
      @required this.onChanged,
      this.readOnly: false,
      this.size})
      : super();

  final ValueChanged<int> onChanged;

  void onPressed() {
    onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new FlatButton(
        color: this.score == this.value ? Colors.green.shade100 : Colors.white,
        onPressed: this.readOnly ? null : this.onPressed,
        shape: new CircleBorder(
          side: new BorderSide(width: 2.0, color: Colors.green.shade200),
        ),
        padding: new EdgeInsets.all(16.0),
        child: new Text(this.value.toString(),
            style: textTheme.headline
                .copyWith(color: Colors.green, fontSize: size)));
  }
}
