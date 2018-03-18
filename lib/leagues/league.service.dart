import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/leagues/league.model.dart';

class LeagueService {
  LeagueService._() {}

  static LeagueService _instance = new LeagueService._();

  /// Gets the instance of LeagueService for the default service app.
  static LeagueService get instance => _instance;

  Stream<QuerySnapshot> findAllAsSnapshot() {
    return Firestore.instance.collection('groups').snapshots;
  }

  Future<DocumentReference> create(League league) {
    return Firestore.instance.collection('groups').add(league.toDocument());
  }

  Future<League> findOne(String id){
    return Firestore.instance.collection('groups').document(id).get().then(
        (document) => new League.fromDocument(document)
    );
  }

  Future<void> update(League league) async {
    Firestore.instance
        .collection('groups')
        .document(league.id)
        .setData(league.toDocument());
  }

  Future<void> upsert(League league) {
    if (league.id != null) {
      return Firestore.instance
          .collection('groups')
          .document(league.id)
          .setData(league.toDocument());
    } else {
      return create(league);
    }
  }
}
