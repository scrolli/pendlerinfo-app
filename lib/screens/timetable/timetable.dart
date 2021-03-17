import 'package:pendlerinfo/models/station.dart';
import 'package:pendlerinfo/screens/timetable/station_selector.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimetablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('Pendlerinfo - Abfahrt'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      body: Container(
          child: StreamProvider<List<Station>>.value(
              initialData: [],
              value: Stream.fromFuture(fetchStations()),
              child: StationSelector())),
    );
  }
}
