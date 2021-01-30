import 'package:pendlerinfo/screens/comments/comments.dart';
import 'package:pendlerinfo/screens/timetable/timetable.dart';
import 'package:pendlerinfo/screens/trackinfos/trackinfos.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
    int _currentIndex = 0;

    Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              title: tabItem.title,
            )
        ],
      ),
    );
  }
}

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: TimetablePage(),
      icon: Icon(Icons.access_time),
      title: Text("Abfahrtszeiten"),
    ),
    TabNavigationItem(
      page: TrackinfosPage(),
      icon: Icon(Icons.add_alert),
      title: Text("Streckenmeldungen"),
    ),
    TabNavigationItem(
      page: CommentsPage(),
      icon: Icon(Icons.comment_rounded),
      title: Text("Kommentare"),
    ),
  ];
}