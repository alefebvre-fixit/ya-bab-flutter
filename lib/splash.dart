import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = new GoogleSignIn();
final auth = FirebaseAuth.instance; // new


class SplashPage extends StatefulWidget {
  @override
  State createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

//    // Listen for our auth event (on reload or start)
//    // Go to our /todos page once logged in
//    _auth.onAuthStateChanged
//        .firstWhere((user) => user != null)
//        .then((user) {
//      Navigator.of(context).pushReplacementNamed('/todos');
//    });
//
//    // Give the navigation animations, etc, some time to finish
//    new Future.delayed(new Duration(seconds: 1))
//        .then((_) => signInWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlatButton(
                  onPressed: () {this._ensureLoggedIn();},
                  child: new Text('Google SignIn'),
                  color: Colors.redAccent,
              ),
//              new CircularProgressIndicator(),
//              new SizedBox(width: 20.0),
//              new Text("Please wait..."),
            ],
          ),
        ],
      ),
    );
  }

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

}
