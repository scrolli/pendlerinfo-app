import 'package:flutter/cupertino.dart';
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
    final departures =
        Provider.of<List<Departure>>(context, listen: true) ?? [];

    var futureDepartures = departures;
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: futureDepartures.length,
        itemBuilder: (context, index) {
          return DepartureTile(departure: futureDepartures[index]);
        },
      ),
      onRefresh: () => _getData()
    );
  }

  Future<void> _getData() async {
    setState(() {});
  }
}
