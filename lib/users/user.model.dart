import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String location;
  final String avatar;

  User({this.id, this.name, this.email, this.avatar, this.location});

  factory User.fromDocument(DocumentSnapshot document) {
    return new User(
        id: document['uid'],
        name: document['displayName'],
        email: document['email'],
        avatar: _getAvatarURL(document),
        location: 'San Francisco');
  }

  static String _getAvatarURL(DocumentSnapshot document) {
    var name = document['displayName'];
    var photoURL = document['photoURL'];

    if (photoURL != null && photoURL != '') {
      return photoURL;
    } else {
      return 'https://ui-avatars.com/api/?rounded=true&name=' + name;
    }
  }
}
