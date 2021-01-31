import 'package:pendlerinfo/models/departure.dart';
import 'package:pendlerinfo/screens/timetable/departure_list.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimetablePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

//    void _showSettingsPanel() {
//      showModalBottomSheet(context: context, builder: (context) {
//        return Container(
//          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
//          //child: SettingsForm(),
//        );
//      });
//    }

    return StreamProvider<List<Departure>>.value(
      value: Stream.fromFuture(fetchDepartures()),
      child: Scaffold(
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
          title: Text('Pendlerinfo'),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        body: Container(
          child: DepartureList()
        ),
      ),
    );
  }
}