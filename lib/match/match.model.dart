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

  int scoreTeam1;
  int scoreTeam2;

  List<Game> games;

  MatchMaking({this.id, this.groupId, this.ownerId, this.date, this.bestOf}) {
    this.team1 = new Team(Team.TEAM_1, Colors.blue);
    this.team2 = new Team(Team.TEAM_2, Colors.red);
  }

  int getScore(Team team) {
    if (team.name == Team.TEAM_1) {
      return scoreTeam1;
    } else {
      return scoreTeam2;
    }
  }

  int getOppositeScore(Team team) {
    if (team.name != Team.TEAM_1) {
      return scoreTeam1;
    } else {
      return scoreTeam2;
    }
  }

  void setScore(Team team, int score) {
    if (team.name == Team.TEAM_1) {
      scoreTeam1 = score;
    } else {
      scoreTeam2 = score;
    }
  }

  bool isScoreSet() {
    return (scoreTeam1 != null && scoreTeam2 != null);
  }

  String getWinner() {
    var result = null;

    if (this.bestOf == 1) {
      result = _getWinner(1);
    } else if (this.bestOf == 3) {
      result = _getWinner(2);
    } else if (this.bestOf == 5) {
      result = _getWinner(3);
    }

    return result;
  }

  String _getWinner(int target) {
    var result = null;

    if (this.scoreTeam1 >= target) {
      result = Team.TEAM_1;
    } else if (this.scoreTeam2 >= target) {
      result = Team.TEAM_2;
    }
    return result;
  }

  void calculateScore() {
    this.scoreTeam1 = null;
    this.scoreTeam2 = null;

    games.forEach((game) {
      var winner = game.getWinner();
      if (winner != null) {
        if (winner == Team.TEAM_1) {
          if (this.scoreTeam1 == null) {
            this.scoreTeam1 = 1;
          } else {
            this.scoreTeam1 += 1;
          }
        } else {
          if (this.scoreTeam2 == null) {
            this.scoreTeam2 = 1;
          } else {
            this.scoreTeam2 += 1;
          }
        }
      }
    });
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

    result.team1 = new Team.fromData(document[Team.TEAM_1], Colors.blue);
    result.team2 = new Team.fromData(document[Team.TEAM_2], Colors.red);

    result.games = new List<Game>();

    Map<dynamic, dynamic> games = document['games'];

    if (games != null) {
      games.forEach((gameId, data) {
        result.games.add(new Game.fromData(data));
      });
    }

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

    result.putIfAbsent(Team.TEAM_1, () {
      return this.team1.toData();
    });

    result.putIfAbsent(Team.TEAM_2, () {
      return this.team2.toData();
    });

    result.putIfAbsent("games", () {
      var gameListData = new Map<String, dynamic>();

      if (games != null && games.length > 0) {
        for (var i = 0; i < games.length; i++) {
          gameListData.putIfAbsent(i.toString(), () {
            return games[i].toData();
          });
        }
      }

      return gameListData;
    });

    return result;
  }
}

class Game {
  final String id;
  int scoreTeam1;
  int scoreTeam2;

  Game({this.id, this.scoreTeam1, this.scoreTeam2});

  Map<String, dynamic> toData() {
    var result = new Map<String, dynamic>();

    result.putIfAbsent("id", () {
      return this.id;
    });
    result.putIfAbsent("scoreTeam1", () {
      return this.scoreTeam1;
    });
    result.putIfAbsent("scoreTeam2", () {
      return this.scoreTeam2;
    });

    return result;
  }

  factory Game.fromData(final Map<dynamic, dynamic> data) {
    Game result = new Game(
      id: data['id'] as String,
      scoreTeam1: data['scoreTeam1'] as int,
      scoreTeam2: data['scoreTeam2'] as int,
    );

    return result;
  }

  String getWinner() {
    var result = null;
    if (isScoreSet()) {
      if (scoreTeam1 > scoreTeam2) {
        result = Team.TEAM_1;
      } else {
        result = Team.TEAM_2;
      }
    }
    return result;
  }

  bool isScoreSet() {
    return (scoreTeam1 != null && scoreTeam2 != null);
  }

  int getScore(Team team) {
    if (team.name == Team.TEAM_1) {
      return scoreTeam1;
    } else {
      return scoreTeam2;
    }
  }

  int getOppositeScore(Team team) {
    if (team.name != Team.TEAM_1) {
      return scoreTeam1;
    } else {
      return scoreTeam2;
    }
  }

  void setScore(Team team, int score) {
    if (team.name == Team.TEAM_1) {
      scoreTeam1 = score;
    } else {
      scoreTeam2 = score;
    }
  }
}

class Team {
  static final TEAM_1 = 'team1';
  static final TEAM_2 = 'team2';

  static final PLAYER_1 = 'player1';
  static final PLAYER_2 = 'player2';

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
      result.putIfAbsent(PLAYER_1, () {
        return this.player1.toDocument();
      });
    } else {
      result.remove(PLAYER_1);
    }

    if (this.player2 != null && this.player2 != null) {
      result.putIfAbsent(PLAYER_2, () {
        return this.player2.toDocument();
      });
    } else {
      result.remove(PLAYER_2);
    }

    return result;
  }

  factory Team.fromData(final Map<dynamic, dynamic> data, Color color) {
    Team result = new Team(data['name'] as String, color);

    if (data[PLAYER_1] != null) {
      result.player1 = new User.fromData(data[PLAYER_1]);
    }
    if (data[PLAYER_2] != null) {
      result.player2 = new User.fromData(data[PLAYER_2]);
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
