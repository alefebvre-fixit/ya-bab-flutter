import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/match/match.model.dart';

class MatchService {
  MatchService._();

  final COLLECTION_MATCH = 'matchs';


  static MatchService _instance = new MatchService._();



  /// Gets the instance of MatchService for the default service app.
  static MatchService get instance => _instance;

  Stream<QuerySnapshot> findAllAsSnapshot() {
    return Firestore.instance.collection('match-makings').snapshots;
  }

  Stream<List<MatchMaking>> findAll() {
    return Firestore.instance
        .collection(COLLECTION_MATCH)
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
        .collection(COLLECTION_MATCH)
        .add(match.toDocument());
  }

  Future<MatchMaking> findOne(String id) {
    return Firestore.instance
        .collection(COLLECTION_MATCH)
        .document(id)
        .get()
        .then((document) => new MatchMaking.fromDocument(document));
  }

  Future<void> update(MatchMaking match) async {
    Firestore.instance
        .collection(COLLECTION_MATCH)
        .document(match.id)
        .setData(match.toDocument());
  }

  Future<void> upsert(MatchMaking match) {
    if (match.id != null) {
      return Firestore.instance
          .collection(COLLECTION_MATCH)
          .document(match.id)
          .setData(match.toDocument());
    } else {
      return create(match);
    }
  }

  Future<MatchMaking> instantiateMatch() async {
    MatchMaking result = new MatchMaking();

    result.bestOf = 3;
    result.date = new DateTime.now();
    result.games = this._instantiateGames(result.bestOf);

    return result;
  }

  List<Game> _instantiateGames(int size) {
    List<Game> result = new List();

    for (var i = 1; i <= size; i++) {
      result.add(new Game(id: i.toString(), scoreTeam1: null, scoreTeam2: null));
    }

    return result;
  }
}
