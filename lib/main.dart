import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // new
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/home.dart';
import 'package:yabab/leagues/create-league.page.dart';
import 'package:yabab/leagues/league-list.page.dart';
import 'package:yabab/match/match-list.dart';
import 'package:yabab/splash.dart';
import 'package:yabab/users/user-list.page.dart';
import 'package:community_material_icon/community_material_icon.dart';


final googleSignIn = new GoogleSignIn();
final auth = FirebaseAuth.instance; // new


void main() => runApp(new MyApp());

Future<Null> _ensureLoggedIn() async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) user = await googleSignIn.signInSilently();
  if (user == null) {
    await googleSignIn.signIn();
  }
  if (await auth.currentUser() == null) {
    //new
    GoogleSignInAuthentication credentials = //new
        await googleSignIn.currentUser.authentication; //new
    await auth.signInWithGoogle(
      //new
      idToken: credentials.idToken, //new
      accessToken: credentials.accessToken, //new
    ); //new
  } //new
}

bool _checkLogin() {
  GoogleSignInAccount user = googleSignIn.currentUser;
  return !(user == null && auth.currentUser == null);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Foosball.io',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Foosball.io'),
      //home: new SplashPage(),
      //home: (_checkLogin() == true ? new SplashPage() : new MyHomePage(title: 'Foosball.io')),



      routes: <String, WidgetBuilder>{
        //5
        '/screen1': (BuildContext context) =>
            new MyHomePage(title: 'Foosball.io'), //6
        //'/screen2': (BuildContext context) => new LeagueWidget(null) //7
      },
    );
  }
}


