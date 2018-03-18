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

  Future<void> upsert(League group) {
    if (group.id != null) {
      return Firestore.instance
          .collection('groups')
          .document(group.id)
          .setData(group.toDocument());
    } else {
      return Firestore.instance.collection('groups').add(group.toDocument());
    }
  }
}
