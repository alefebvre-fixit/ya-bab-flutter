import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yabab/users/user.model.dart';

class MatchMaking {

  final String id;
  final String groupId;
  final String ownerId;
  final String date;
  final int players;
  final int bestOf;

  Team team1;
  Team team2;

  MatchMaking(
      {this.id,
        this.groupId,
        this.ownerId,
        this.date,
        this.players,
        this.bestOf
      }){

    this.team1 = new Team('teamA', Colors.blue);
    this.team2 = new Team('teamB', Colors.red);

  }

  bool isPlaying(String userId){

    if (this.team1 != null && team1.isPlaying(userId)){
      return true;
    }

    if (this.team2 != null && team2.isPlaying(userId)){
      return true;
    }

    return false;
  }

  factory MatchMaking.fromDocument(DocumentSnapshot json) {
    return new MatchMaking(
      id: json['id'] as String,
      groupId: json['groupId']  as String,
      ownerId: json['ownerId'] as String,
      date: json['date'] as String,
      players: json['players'] as int,
      bestOf: json['bestOf'] as int,
    );
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

    result.putIfAbsent("players", () {
      return this.players;
    });

    result.putIfAbsent("bestOf", () {
      return this.bestOf;
    });

    return result;
  }
}


class Game {

  final String id;
  final int scoreTeamA;
  final int scoreTeamB;

  Game(
      {this.id,
        this.scoreTeamA,
        this.scoreTeamB});


}


class Team {

  final String name;

  final Color color;

  Team(this.name, this.color);

  User player1;
  User player2;

  bool isPlaying(String userId){

    if (this.player1 != null && player1.id == userId){
      return true;
    }

    if (this.player2 != null && player2.id == userId){
      return true;
    }

    return false;
  }

}

