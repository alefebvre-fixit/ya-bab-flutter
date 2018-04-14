import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/users/user.model.dart';
import 'package:yabab/users/user.page.dart';
import 'package:yabab/users/user.service.dart';
import 'package:yabab/users/user.tile.dart';

enum PlayerDialogAction {
  cancel,
  discard,
  save,
}

class PlayerDialog extends StatefulWidget {

  @override
  PlayerDialogState createState() => new PlayerDialogState();

}

class PlayerDialogState extends State<PlayerDialog> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: const Text('Player Selector'), actions: <Widget>[
        ]),
        body: new UserList());
  }
}


class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: UserService.instance.findAllUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.map((user) {
            return new UserListTile(user, () => _navigateToUserDetails(user, context));
          }).toList(),
        );
      },
    );
  }
}

void _navigateToUserDetails(User user, BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (c) {
        return new UserDetailsPage(user);
      },
    ),
  );
}







