import 'package:flutter/material.dart';
import 'package:yabab/match/game.score.dart';
import 'package:yabab/match/match.model.dart';

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
  _GameDialogState createState() => new _GameDialogState(match, game);
}

class _GameDialogState extends State<GameDialog>
    with SingleTickerProviderStateMixin {
  final MatchMaking match;
  final Game game;

  TabController _tabController;

  _GameDialogState(this.match, this.game);

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        vsync: this, length: match.games != null ? match.games.length : 0);

    if (game != null) {
      _tabController.animateTo(int.parse(game.id) - 1);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Game Score'),
        bottom: new PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: new Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: new Container(
              height: 48.0,
              alignment: Alignment.center,
              child: new TabPageSelector(controller: _tabController),
            ),
          ),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: this.match.games.map((aGame) {
          return new GameScore(match, aGame);
        }).toList(),
      ),
    );
  }
}
