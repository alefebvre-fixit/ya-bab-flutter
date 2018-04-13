import 'package:flutter/material.dart';

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
    var textTheme = theme.textTheme;

    return new Scaffold(
        appBar: new AppBar(title: const Text('New event'), actions: <Widget>[
          new FlatButton(
              child: new Text('SAVE',
                  style: theme.textTheme.body1.copyWith(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context, DismissDialogAction.save);
              })
        ]),
        body: new Container(
            child: new Padding(
          padding: new EdgeInsets.all(12.0),
          child: new Column(
            children: <Widget>[
              new Text('Game 1',
                  style: textTheme.headline.copyWith(color: Colors.green)),

              new TeamScoreTable('Blue Team', Colors.blue),
              new Padding(
                padding: new EdgeInsets.all(12.0),
                child: new Text('VS',
                    style: textTheme.headline.copyWith(color: Colors.grey))
              ),
              new TeamScoreTable('Red Team', Colors.red),

            ],
          ),
        )));
  }
}

class TeamScoreTable extends StatelessWidget {

  TeamScoreTable(this.name, this.color);

  final String name;
  final Color color;


  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    var textTheme = theme.textTheme;


    var table =  new Table(
        columnWidths: const <int, TableColumnWidth>{},
        children: <TableRow>[
          new TableRow(children: <Widget>[
            new ScoreCell(0),
            new ScoreCell(1),
            new ScoreCell(2),
            new ScoreCell(3),
            new ScoreCell(4),
          ]),
          new TableRow(children: <Widget>[
            new ScoreCell(5),
            new ScoreCell(6),
            new ScoreCell(7),
            new ScoreCell(8),
            new ScoreCell(9),
          ]),
        ]);

    return new Column(
      children: <Widget>[
        new Text(name,
            style: textTheme.title.copyWith(color: color)),
        table,
      ],
    );



  }
}

class ScoreTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Table(
        columnWidths: const <int, TableColumnWidth>{},
        children: <TableRow>[
          new TableRow(children: <Widget>[
            new ScoreCell(1),
            new ScoreCell(2),
            new ScoreCell(3),
          ]),
          new TableRow(children: <Widget>[
            new ScoreCell(4),
            new ScoreCell(5),
            new ScoreCell(6),
          ]),
          new TableRow(children: <Widget>[
            new ScoreCell(7),
            new ScoreCell(8),
            new ScoreCell(9),
          ]),
        ]);
  }
}

class ScoreCell extends StatelessWidget {
  final int value;

  ScoreCell(this.value);

  @override
  Widget build(BuildContext context) {
    return new TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: new Padding(
            padding: new EdgeInsets.all(6.0), child: new ScoreButton(value)));
  }
}


class ScoreButton extends StatefulWidget {

  final int value;


  ScoreButton(this.value);

  @override
  _ScoreButtonState createState() => new _ScoreButtonState(value);
}




class _ScoreButtonState extends State<ScoreButton> {
  bool _active = false;

  final int value;

  _ScoreButtonState(this.value);

  void onPressed() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new FlatButton(

        color: _active ? Colors.green.shade100 : Colors.white10,
        onPressed: this.onPressed,
        shape: new CircleBorder(
          side: new BorderSide(width: 2.0, color: Colors.green.shade200),
        ),
        padding: new EdgeInsets.all(16.0),
        child: new Text(this.value.toString(),
            style: textTheme.headline.copyWith(color: Colors.green)));
  }
}
