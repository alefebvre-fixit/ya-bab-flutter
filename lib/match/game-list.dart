import 'package:flutter/material.dart';
import 'package:yabab/match/game.dialog.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/match/match.service.dart';


class GameList extends StatelessWidget {
  GameList(this.match);

  final MatchMaking match;

  @override
  Widget build(BuildContext context) {

    return new ListView.builder(
      itemCount: match.games != null ? match.games.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return new _GameListTile(this.match, match.games[index]);
      },
    );
  }

}

class _GameListTile extends StatelessWidget {
  final Game game;
  final MatchMaking match;

  _GameListTile(this.match, this.game);

  _buildStar(BuildContext context, Team team, int score) {
    if (score == null) {
      return new Icon(
        Icons.star_border,
        color: Colors.black38,
      );
    } else if (score >= 10) {
      return new Icon(
        Icons.star,
        color: team.color,
      );
    } else {
      return new Icon(
        Icons.star_border,
        color: Colors.black12,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute<DismissDialogAction>(
                builder: (BuildContext context) =>
                new GameDialog(match, game),
                fullscreenDialog: true,
              ));
        },
        leading: _buildStar(context, match.team1, game.scoreTeam1),
        title: new _GameScore(
          game,
        ),
        trailing: _buildStar(context, match.team2, game.scoreTeam2));
  }
}

class _GameScore extends StatelessWidget {
  final Game game;

  _GameScore(this.game);

  _buildScoreText(BuildContext context, int score) {
    Color color = score != null ? Colors.black54 : Colors.black38;

    return new Text(
      score != null ? score.toString() : '-',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline.copyWith(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            width: 40.0,
            child: _buildScoreText(context, game.scoreTeam1),
          ),
          new Container(
              width: 20.0,
              child: new Text(
                ':',
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Colors.black54),
              )),
          new Container(
            width: 40.0,
            child: _buildScoreText(context, game.scoreTeam2),
          ),
        ],
      ),
    );
  }
}
