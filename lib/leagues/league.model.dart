
import 'package:cloud_firestore/cloud_firestore.dart';

class League {
  final String name;
  final String location;
  final String id;

  League({this.id, this.name, this.location});

  factory League.fromDocument(DocumentSnapshot document) {
    return new League(
      id: document.documentID,
      name: document['name'],
      location:
          document['location'] != null ? document['location'] : 'Somewhere',
    );
  }

  Map<String, dynamic> toDocument() {
    var result = new Map<String, dynamic>();

    result.putIfAbsent("name", () {
      return this.name;
    });
    result.putIfAbsent("location", () {
      return this.location;
    });

    return result;
  }
}
