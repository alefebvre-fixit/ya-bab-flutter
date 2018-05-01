import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yabab/leagues/league.model.dart';
import 'package:yabab/users/user.model.dart';

class LeagueService {
  LeagueService._();

  final COLLECTION_LEAGUE = 'leagues';
  final COLLECTION_USER = 'users';

  static LeagueService _instance = new LeagueService._();

  /// Gets the instance of LeagueService for the default service app.
  static LeagueService get instance => _instance;

  Stream<QuerySnapshot> findAllAsSnapshot() {
    return Firestore.instance.collection(COLLECTION_LEAGUE).snapshots;
  }

  Stream<List<League>> findAll(){
    return Firestore.instance.collection(COLLECTION_LEAGUE).snapshots.map((query) => query.documents).map( (documents) => _fromDocuments(documents));
  }

  List<League> _fromDocuments(List<DocumentSnapshot> documents){
    return documents.map((document) => new League.fromDocument(document)).toList();
  }

  Future<DocumentReference> create(League league) {
    return Firestore.instance.collection(COLLECTION_LEAGUE).add(league.toDocument());
  }

  Future<League> findOne(String id) {
    return Firestore.instance
        .collection(COLLECTION_LEAGUE)
        .document(id)
        .get()
        .then((document) => new League.fromDocument(document));
  }

  Future<void> update(League league) async {
    Firestore.instance
        .collection(COLLECTION_LEAGUE)
        .document(league.id)
        .setData(league.toDocument());
  }

  Future<void> upsert(League league) {
    if (league.id != null) {
      return Firestore.instance
          .collection(COLLECTION_LEAGUE)
          .document(league.id)
          .setData(league.toDocument());
    } else {
      return create(league);
    }
  }

  Future<bool> isFollowing(String leagueId) {
    return Firestore.instance
        .collection(COLLECTION_LEAGUE + '/' + leagueId + '/followers')
        .where('follower', isEqualTo: "XZYg8mMKrmS9xjVtn7yIScuMp622")
        .snapshots
        .first
        .then((query) {
      return query.documents.isNotEmpty;
    });
  }

  Future<void> follow(String leagueId) {
    return FirebaseAuth.instance.currentUser().then((user) {
      return Firestore.instance
          .collection(COLLECTION_LEAGUE + '/' + leagueId + '/followers')
          .add({"follower": "XZYg8mMKrmS9xjVtn7yIScuMp622"}
      );
    });
  }

  Future<void> unfollow(String leagueId) {
    return FirebaseAuth.instance.currentUser().then((user) {
      return Firestore.instance
          .collection(COLLECTION_LEAGUE + '/' + leagueId + '/followers')
          .where('follower', isEqualTo: "XZYg8mMKrmS9xjVtn7yIScuMp622")
          .snapshots
          .first
          .then((query) {
        query.documents.forEach((document) {
          document.reference.delete();
        });
      });
    });
  }

  Future<QuerySnapshot> findAllFollowersAsSnapshot(String leagueId) {
    return Firestore.instance
        .collection(COLLECTION_LEAGUE + '/' + leagueId + '/followers')
        .snapshots
        .first;
  }


  Future<List<User>> findAllFollowers(String leagueId) async {
    return Firestore
        .instance
        .collection(COLLECTION_LEAGUE + '/' + leagueId + '/followers').getDocuments()
        .then((querySnapshot) => querySnapshot.documents)
        .then((documentSnapshots) => documentSnapshots.map((document) => document['follower'] as String))
        .then((ids) { print(ids); return ids; })
        .then( (ids) => ids.map( (id) => findOneUser(id) ))
        .then((futureUsers) => Future.wait(futureUsers));
  }

  Future<User> findOneUser(String id) {
  return Firestore.instance
      .collection(COLLECTION_USER)
      .document(id)
      .get()
      .then((document) => new User.fromDocument(document));
  }


}
