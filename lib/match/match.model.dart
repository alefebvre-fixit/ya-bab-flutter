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
      id: json['id'] as String,
      groupId: json['groupId']  as String,
      ownerId: json['ownerId'] as String,
      date: json['date'] as String,
      players: json['players'] as int,
      games: json['games'] as int,
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

    result.putIfAbsent("games", () {
      return this.games;
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

