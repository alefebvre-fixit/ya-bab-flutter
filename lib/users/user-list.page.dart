import 'package:flutter/material.dart';
import 'package:yabab/users/user.model.dart';
import 'package:yabab/users/user.page.dart';
import 'package:yabab/users/user.service.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new UserList();
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
            return new UserListTile(user);
          }).toList(),
        );
      },
    );
  }
}

class UserListTile extends StatelessWidget {

  final User user;

  UserListTile(this.user);

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

void _navigateToUserDetails(User user, BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (c) {
        return new UserDetailsPage(user);
      },
    ),
  );
}
