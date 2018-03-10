import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/users/user.model.dart';
import 'package:yabab/users/user.page.dart';
import 'package:yabab/users/user.service.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream:  UserService.instance.findAllAsSnapshot(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((document) {
            return new UserListTile(new User.fromDocument(document));
          }).toList(),
        );
      },
    );
  }
}

class UserListTile extends StatelessWidget {
  User user;

  UserListTile(User user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () => _navigateToUserDetails(this.user, context),
      leading: new Hero(
        tag: user.id,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(user.avatar),
        ),
      ),
      title: new Text(user.name),
      subtitle: new Text(user.email),
    );
  }
}

_navigateToUserDetails(User user, BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (c) {
        return new UserDetailsPage(user);
      },
    ),
  );
}
