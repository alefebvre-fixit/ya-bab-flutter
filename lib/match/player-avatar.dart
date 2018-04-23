import 'package:flutter/widgets.dart';
import 'package:yabab/match/match.model.dart';
import 'package:yabab/users/user.avatar.dart';
import 'package:yabab/users/user.model.dart';

class PlayerAvatar extends StatelessWidget {
  final MatchMaking match;
  final Team team;
  final User user;

  PlayerAvatar(this.match, this.team, this.user);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {},
        child: new Container(
            child: new UserAvatar(user),
            padding: const EdgeInsets.all(3.0),
            decoration: new BoxDecoration(
              color: team.color, // border color
              shape: BoxShape.circle,
            )));
  }
}
