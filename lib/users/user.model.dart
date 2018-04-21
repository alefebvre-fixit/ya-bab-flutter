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
        id: document['uid'] as String,
        name: document['displayName'] as String,
        email: document['email'] as String,
        avatar: _getAvatarURL(document),
        location: 'San Francisco');
  }

  Map<String, dynamic> toDocument() {
    var result = new Map<String, dynamic>();

    result.putIfAbsent("displayName", () {
      return this.name;
    });

    result.putIfAbsent("ownerId", () {
      return this.email;
    });

    result.putIfAbsent("photoURL", () {
      return this.avatar;
    });

    return result;
  }

  static String _getAvatarURL(DocumentSnapshot document) {
    var name = document['displayName'] as String;
    var photoURL = document['photoURL'] as String;

    if (photoURL != null && photoURL != '') {
      return photoURL;
    } else {
      return 'https://ui-avatars.com/api/?rounded=true&name=' + name;
    }
  }
}
