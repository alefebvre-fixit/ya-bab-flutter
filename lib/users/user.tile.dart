import 'package:flutter/material.dart';
import 'package:yabab/users/user.avatar.dart';
import 'package:yabab/users/user.model.dart';
import 'package:yabab/users/user.page.dart';
import 'package:yabab/users/user.service.dart';

class UserListTile extends StatelessWidget {
  final User user;
  final Function onTap;

  UserListTile(this.user, this.onTap);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: this.onTap,
      leading: new UserAvatarHero(user: user),
      title: new Text(user.name),
      subtitle: new Text(user.email),
    );
  }
}
