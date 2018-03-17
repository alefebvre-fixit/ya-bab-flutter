import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/groups/group.model.dart';

class GroupService {
  GroupService._() {}

  static GroupService _instance = new GroupService._();

  /// Gets the instance of GroupService for the default service app.
  static GroupService get instance => _instance;

  Stream<QuerySnapshot> findAllAsSnapshot() {
    return Firestore.instance.collection('groups').snapshots;
  }

  Future<void> upsert(Group group) {
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
