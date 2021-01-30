import 'package:pendlerinfo/models/departure.dart';
import 'package:pendlerinfo/screens/timetable/departure_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepartureList extends StatefulWidget {
  @override
  _DepartureListState createState() => _DepartureListState();
}

class _DepartureListState extends State<DepartureList> {
  @override
  Widget build(BuildContext context) {

    final departures = Provider.of<List<Departure>>(context) ?? [];

    return ListView.builder(
      itemCount: departures.length,
      itemBuilder: (context, index) {
        return DepartureTile(departure: departures[index]);
      },
    );
  }

}