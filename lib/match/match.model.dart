import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yabab/users/user.model.dart';

class MatchMaking {
  final String id;
  final String groupId;
  final String ownerId;

  DateTime date;
  int bestOf;

  Team team1;
  Team team2;


  MatchMaking({this.id, this.groupId, this.ownerId, this.date, this.bestOf}) {
    this.team1 = new Team('teamA', Colors.blue);
    this.team2 = new Team('teamB', Colors.red);
  }

  bool isPlaying(String userId) {
    if (this.team1 != null && team1.isPlaying(userId)) {
      return true;
    }

    if (this.team2 != null && team2.isPlaying(userId)) {
      return true;
    }

    return false;
  }

  factory MatchMaking.fromDocument(DocumentSnapshot document) {
    MatchMaking result = new MatchMaking(
      id: document.documentID,
      groupId: document['groupId'] as String,
      ownerId: document['ownerId'] as String,
      date: document['date'] as DateTime,
      bestOf: document['bestOf'] as int,
    );

    result.team1 = new Team.fromData(document['team1'], Colors.blue);
    result.team2 = new Team.fromData(document['team2'], Colors.red);

    return result;
  }

  Map<String, dynamic> toDocument() {
    var result = new Map<String, dynamic>();

    result.putIfAbsent("groupId", () {
      return this.groupId;
    });
    result.putIfAbsent("ownerId", () {
      return this.ownerId;
    });

    result.putIfAbsent("date", () {
      return this.date;
    });

    result.putIfAbsent("bestOf", () {
      return this.bestOf;
    });

    result.putIfAbsent("team1", () {
      return this.team1.toData();
    });

    result.putIfAbsent("team2", () {
      return this.team2.toData();
    });

    return result;
  }
}

class Game {
  final String id;
  final int scoreTeamA;
  final int scoreTeamB;

  Game({this.id, this.scoreTeamA, this.scoreTeamB});
}

class Team {
  final String name;

  final Color color;

  Team(this.name, this.color);

  User player1;
  User player2;

  Map<String, dynamic> toData() {
    var result = new Map<String, dynamic>();

    result.putIfAbsent("name", () {
      return this.name;
    });

    if (this.player1 != null && this.player1 != null) {
      result.putIfAbsent("player1", () {
        return this.player1.toDocument();
      });
    } else {
      result.remove("player1");
    }

    if (this.player2 != null && this.player2 != null) {
      result.putIfAbsent("player2", () {
        return this.player2.toDocument();
      });
    } else {
      result.remove("player2");
    }

    return result;
  }

  factory Team.fromData(final Map<dynamic, dynamic> data, Color color) {
    Team result = new Team(data['name'] as String, color);

    if (data['player1'] != null) {
      result.player1 = new User.fromData(data['player1']);
    }
    if (data['player2'] != null) {
      result.player2 = new User.fromData(data['player2']);
    }

    return result;
  }

  bool isPlaying(String userId) {
    if (this.player1 != null && player1.id == userId) {
      return true;
    }

    if (this.player2 != null && player2.id == userId) {
      return true;
    }

    return false;
  }
}
