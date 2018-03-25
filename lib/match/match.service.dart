import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/match/match.model.dart';

class MatchService {
  MatchService._();

  static MatchService _instance = new MatchService._();

  /// Gets the instance of MatchService for the default service app.
  static MatchService get instance => _instance;

  Stream<QuerySnapshot> findAllAsSnapshot() {
    return Firestore.instance.collection('match-makings').snapshots;
  }

  Stream<List<MatchMaking>> findAll() {
    return Firestore.instance
        .collection('match-makings')
        .snapshots
        .map((query) => query.documents)
        .map((documents) => _fromDocuments(documents));
  }

  List<MatchMaking> _fromDocuments(List<DocumentSnapshot> documents) {
    return documents
        .map((document) => new MatchMaking.fromDocument(document))
        .toList();
  }

  Future<DocumentReference> create(MatchMaking match) {
    return Firestore.instance
        .collection('match-makings')
        .add(match.toDocument());
  }

  Future<MatchMaking> findOne(String id) {
    return Firestore.instance
        .collection('match-makings')
        .document(id)
        .get()
        .then((document) => new MatchMaking.fromDocument(document));
  }

  Future<void> update(MatchMaking match) async {
    Firestore.instance
        .collection('match-makings')
        .document(match.id)
        .setData(match.toDocument());
  }

  Future<void> upsert(MatchMaking match) {
    if (match.id != null) {
      return Firestore.instance
          .collection('match-makings')
          .document(match.id)
          .setData(match.toDocument());
    } else {
      return create(match);
    }
  }
}
