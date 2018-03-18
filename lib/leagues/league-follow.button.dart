import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yabab/leagues/league.model.dart';
import 'package:yabab/leagues/league.service.dart';

class LeagueFollowButton extends StatefulWidget {
  final League league;

  LeagueFollowButton(this.league);

  @override
  _FollowButtonState createState() => new _FollowButtonState(league);
}

class _FollowButtonState extends State<LeagueFollowButton> {
  League league;
  bool following;

  _FollowButtonState(League league) {
    this.league = league;
  }

  String status = 'Follow';

  void onPressed() {
    if (this.following) {
      this._unfollow();
    } else {
      this._follow();
    }
  }

  Future<Null> _follow() async {
    setState(() {
      this.following = true;
      LeagueService.instance.follow(this.league.id);
      status = this.following ? 'Followed' : 'Follow';
    });
  }

  Future<Null> _unfollow() async {
    switch (await _unfollowDialog()) {
      case true:
        setState(() {
          this.following = false;
          LeagueService.instance.unfollow(this.league.id);
          status = this.following ? 'Followed' : 'Follow';
        });
        break;
      case false:
        break;
    }
  }

  Future<bool> _unfollowDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      child: new AlertDialog(
        title: new Text('Unfollow'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('Stop following ' + this.league.name + '?'),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('NO'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          new FlatButton(
            child: new Text('YES'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    LeagueService.instance.isFollowing(this.league.id).then((isFollowing) {
      setState(() {
        following = isFollowing;
        status = following ? 'Followed' : 'Follow';
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: Colors.lightGreen,
        textColor: Colors.white,
        onPressed: onPressed,
        child: new Text(status),
      ),
    );
  }
}
