import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yabab/leagues/create-league.page.dart';
import 'package:yabab/leagues/league-list.page.dart';
import 'package:yabab/match/match-list.dart';
import 'package:yabab/users/user-list.page.dart';


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

enum YaBabAction { createLeague }


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
            title: new Text('fusball.io'),
            actions: <Widget>[
              new PopupMenuButton<YaBabAction>(
                onSelected: (YaBabAction value) =>
                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new CreateLeagueWidget(null);
                      },
                    )),
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<YaBabAction>>[
                  const PopupMenuItem<YaBabAction>(
                    value: YaBabAction.createLeague,
                    child: const Text('Create new League'),
                  ),
                ],
              )
            ]),
        body: new PageView(children: [
          new LeagueListPage(),
          new MatchMakingListPage(),
          new UserListPage()
        ], controller: _pageController, onPageChanged: onPageChanged),
        bottomNavigationBar: new BottomNavigationBar(
            items: [
              new BottomNavigationBarItem(
                  icon: new Icon(CommunityMaterialIcons.trophy), title: new Text("Leagues")),
              new BottomNavigationBarItem(
                  icon: new Icon(CommunityMaterialIcons.soccer_field), title: new Text("Match")),
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