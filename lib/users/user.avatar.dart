import 'package:flutter/material.dart';
import 'package:yabab/users/user.model.dart';
import 'package:yabab/users/user.page.dart';
import 'package:yabab/users/user.service.dart';

class UserAvatar extends StatelessWidget {
  final User user;

  UserAvatar(this.user);

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (user == null) {
      avatar = new CircleAvatar(
        child: const Text('?'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.white30,
      );
    } else {
      if (user.avatar != null) {
        avatar = new CircleAvatar(
          backgroundImage: new NetworkImage(user.avatar),
        );
      } else {
        avatar = new CircleAvatar(
          backgroundImage: new NetworkImage(
              'https://ui-avatars.com/api/?rounded=true&name=' + user.name),
        );
      }
    }
    return avatar;
  }
}

class UserAvatarHero extends StatelessWidget {
  final User user;
  double radius;

  UserAvatarHero({this.user, this.radius});

  @override
  Widget build(BuildContext context) {
    Widget avatar;

    if (user == null) {
      avatar = new CircleAvatar(
        child: const Text('?'),
        radius: radius,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      if (user.avatar != null) {
        avatar = new Hero(
          tag: user.id,
          child: new CircleAvatar(
            backgroundImage: new NetworkImage(user.avatar),
          ),
        );
      } else {
        avatar = new Hero(
          tag: user.id,
          child: new CircleAvatar(
            backgroundImage: new NetworkImage(
                'https://ui-avatars.com/api/?rounded=true&name=' + user.name),
          ),
        );
      }
    }

    return avatar;
  }
}
