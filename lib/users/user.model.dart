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
        avatar: document['photoURL'] as String,
        location: document['location']);
  }

  factory User.fromData(final Map<dynamic, dynamic> data) {
    return new User(
        id: data['uid'] as String,
        name: data['displayName'] as String,
        email: data['email'] as String,
        avatar: data['photoURL'] as String,
        location: data['location'] as String);
  }

  Map<String, dynamic> toDocument() {
    var result = new Map<String, dynamic>();

    result.putIfAbsent("uid", () {
      return this.id;
    });

    result.putIfAbsent("displayName", () {
      return this.name;
    });

    result.putIfAbsent("email", () {
      return this.email;
    });

    result.putIfAbsent("photoURL", () {
      return this.avatar;
    });

    result.putIfAbsent("location", () {
      return this.location;
    });

    return result;
  }

//  static String _getAvatarURL(DocumentSnapshot document) {
//    var name = document['displayName'] as String;
//    var photoURL = document['photoURL'] as String;
//
//    if (photoURL != null && photoURL != '') {
//      return photoURL;
//    } else {
//      return 'https://ui-avatars.com/api/?rounded=true&name=' + name;
//    }
//  }
}
