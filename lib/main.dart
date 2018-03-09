import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // new
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_database/firebase_database.dart'; //new
import 'package:firebase_database/ui/firebase_animated_list.dart'; //new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yabab/groups/group-list.page.dart';
import 'package:yabab/groups/group.page.dart';
import 'package:yabab/match/match.dart';
import 'package:yabab/users/user-list.page.dart';

final googleSignIn = new GoogleSignIn();
final auth = FirebaseAuth.instance; // new

final reference = Firestore.instance.collection('groups');

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
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
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        //5
        '/screen1': (BuildContext context) =>
            new MyHomePage(title: 'Flutter Demo Home Page'), //6
        '/screen2': (BuildContext context) => new GroupWidget(null) //7
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Indicating the current displayed page
  /// 0: leagues
  /// 1: match
  /// 2: users
  int _page = 0;

  /// This controller can be used to programmatically
  /// set the current displayed page
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text(widget.title),
        ),
        body: new PageView(children: [
          new GroupListPage(),
          new MatchMakingListPage(),
          new UserListPage()
        ], controller: _pageController, onPageChanged: onPageChanged),
        bottomNavigationBar: new BottomNavigationBar(
            items: [
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.add), title: new Text("Leagues")),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.location_on), title: new Text("Match")),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.people), title: new Text("Users"))
            ],

            /// Will be used to scroll to the next page
            /// using the _pageController
            onTap: navigationTapped,
            currentIndex: _page));
  }

  /// Called when the user presses on of the
  /// [BottomNavigationBarItem] with corresponding
  /// page index
  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
