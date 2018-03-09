import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String id;
  final String name;
  final String email;
  final String photoURL;


  User({this.id, this.name, this.email, this.photoURL});

  factory User.fromDocument(DocumentSnapshot json) {
    return new User(
      id: json['uid'],
      name: json['displayName'],
      email: json['email'],
      photoURL: json['photoURL'],
    );
  }

  String getAvatarURL(){

    if (photoURL != null && photoURL != ''){
      return photoURL;
    } else {
      return 'https://ui-avatars.com/api/?name=ElonMusk';
    }

  }


}