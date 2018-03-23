import 'package:cloud_firestore/cloud_firestore.dart';

class MatchMaking {
  final String id;
  final String groupId;
  final String ownerId;
  final String date;
  final int players;
  final int games;

  MatchMaking(
      {this.id,
        this.groupId,
        this.ownerId,
        this.date,
        this.players,
        this.games});

  factory MatchMaking.fromDocument(DocumentSnapshot json) {
    return new MatchMaking(
      id: json['id'],
      groupId: json['groupId'],
      ownerId: json['ownerId'],
      date: json['date'],
      players: json['players'],
      games: json['games'],
    );
  }
}


class Match {
  final String id;
  final String groupId;
  final String ownerId;
  final String date;
  final int players;
  final int games;

  Match(
      {this.id,
        this.groupId,
        this.ownerId,
        this.date,
        this.players,
        this.games});

  factory Match.fromDocument(DocumentSnapshot json) {
    return new Match(
      id: json['id'],
      groupId: json['groupId'],
      ownerId: json['ownerId'],
      date: json['date'],
      players: json['players'],
      games: json['games'],
    );
  }
}