import 'package:flutter/material.dart';
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/users/user.model.dart';



class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots,
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
      onTap: () => {},
      leading: new Hero(
        tag: user.id,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(user.getAvatarURL()),
        ),
      ),
      title: new Text(user.name),
      subtitle: new Text(user.email),
    );
  }



}

