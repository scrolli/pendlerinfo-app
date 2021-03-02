import 'package:flutter/cupertino.dart';
import 'package:pendlerinfo/models/departure.dart';
import 'package:pendlerinfo/models/station.dart';
import 'package:pendlerinfo/screens/timetable/departure_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';

class DepartureList extends StatefulWidget {
  final Station _departure;
  final Station _destination;

  DepartureList(this._departure, this._destination);

  @override
  _DepartureListState createState() => _DepartureListState(_departure, _destination);
}

class _DepartureListState extends State<DepartureList> {
  final Station _departure;
  final Station _destination;
  List<Departure> departures;

  _DepartureListState(this._departure, this._destination);

  @override
  Widget build(BuildContext context) {
    //final departures =
    departures = Provider.of<List<Departure>>(context, listen: true) ?? [];

    var futureDepartures = departures;
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: futureDepartures.length,
        itemBuilder: (context, index) {
          return DepartureTile(departure: futureDepartures[index], station: _departure);
        },
      ),
      onRefresh: () => _getData()
    );
  }

  Future<void> _getData() async {
    setState(() {
      fetchDepartures(_departure.eva, _destination).then((value) => this.departures = value);
    });
  }
}
