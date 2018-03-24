import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yabab/leagues/league.model.dart';
import 'package:yabab/users/user.model.dart';

class LeagueService {
  LeagueService._();

  static LeagueService _instance = new LeagueService._();

  /// Gets the instance of LeagueService for the default service app.
  static LeagueService get instance => _instance;

  Stream<QuerySnapshot> findAllAsSnapshot() {
    return Firestore.instance.collection('groups').snapshots;
  }

  Future<DocumentReference> create(League league) {
    return Firestore.instance.collection('groups').add(league.toDocument());
  }

  Future<League> findOne(String id) {
    return Firestore.instance
        .collection('groups')
        .document(id)
        .get()
        .then((document) => new League.fromDocument(document));
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

  Future<bool> isFollowing(String leagueId) {
    return Firestore.instance
        .collection('groups/' + leagueId + '/followers')
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
          .collection('groups/' + leagueId + '/followers')
          .add({"follower": "XZYg8mMKrmS9xjVtn7yIScuMp622"});
    });
  }

  Future<void> unfollow(String leagueId) {
    return FirebaseAuth.instance.currentUser().then((user) {
      return Firestore.instance
          .collection('groups/' + leagueId + '/followers')
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
        .collection('groups/' + leagueId + '/followers')
        .snapshots
        .first;
  }

//  Future<List<User>> findAllFollowers(String leagueId) async {
//
//      var followerIds$ = new Observable<QuerySnapshot>.fromFuture(Firestore.instance
//          .collection('groups/' + leagueId + '/followers').snapshots.first);
//
//      return new Observable<QuerySnapshot>.fromFuture(Firestore.instance
//      .collection('groups/' + leagueId + '/followers')
//      .snapshots
//      .first)
//      .map((querySnapshot) => querySnapshot.documents)
//      .map( (documents) => documents.map( (document) => UserService.instance.findOne(document['follower'])))
//      .map( )
//  ;
//
//  }

  Future<List<User>> findAllFollowers(String leagueId) async {
    return Firestore
        .instance
        .collection('groups/' + leagueId + '/followers').getDocuments()
        .then((querySnapshot) => querySnapshot.documents)
        .then((documentSnapshots) => documentSnapshots.map((document) => document['follower']))
        .then((ids) { print(ids); return ids; })
        .then( (ids) => ids.map( (id) => findOneUser(id) ))
        .then((futurUsers) => Future.wait(futurUsers));
  }

//  void findAllFollowers2(String leagueId) async {
//  var followerIds$ = new Observable<QuerySnapshot>.fromFuture(Firestore
//      .instance
//      .collection('groups/' + leagueId + '/followers').getDocuments())
//      .map((querySnapshot) => querySnapshot.documents)
//      .map((documents) { print(documents); return documents; })
//      .map((documents) => documents.map((document) {print(documents); return document["follower"];} ))
//      .map((documents) { print(documents); return documents; })
//
//  ;
//
//
//  followerIds$
//      .map( (ids) => ids.map( (id) => findOneUser(id) ))
//      .flatMap( (users) => new Observable<User>.concat(users))
//
//
//
//
//      .listen((x) => print("Next: $x"),
//  onError: (e, s) => print("Error: $e"),
//  onDone: () => print("Completed"));
//
//
//  }


  Future<User> findOneUser(String id) {
  return Firestore.instance
      .collection('users')
      .document(id)
      .get()
      .then((document) => new User.fromDocument(document));
  }

//  List<User> _asUserList(List<DocumentSnapshot> documents){
//
//  documents.map((document).)
//
//  }

//  Stream<List<User>> findAllUsers(){
//    return Firestore.instance.collection('users').snapshots.map((query) => query.documents).map( (documents) => _fromDocuments(documents.));
//  }
}
