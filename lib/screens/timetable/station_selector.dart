import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pendlerinfo/models/departure.dart';
import 'package:pendlerinfo/models/station.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';
import 'package:provider/provider.dart';

import 'departure_list.dart';

class StationSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StationSelectorState();
}

class _StationSelectorState extends State<StationSelector> {
  Station _departureStation;
  Station _destinationStation;
  Future<List<Departure>> _data;

  @override
  Widget build(BuildContext context) {
    final stations = Provider.of<List<Station>>(context) ?? [];

    if (_departureStation == null) {
      _departureStation = stations.where((s) => s.eva == 8000261).first;
    }
    if (_destinationStation == null) {
      _destinationStation = stations.where((s) => s.eva == 8003982).first;
    }
    _data = fetchDepartures(_departureStation.eva, _destinationStation);

    return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 7,
              child: DropdownSearch<Station>(
                mode: Mode.BOTTOM_SHEET,
                maxHeight: 300,
                items: stations,
                selectedItem: _departureStation,
                label: "Abfahrt",
                onChanged: (dynamic value) {
                  var _prevDeparture = _departureStation;
                  if (value.eva == _destinationStation) {
                    _destinationStation = _prevDeparture;
                  }
                  setState(() => _departureStation = value);
                },
                showSearchBox: true,
                searchBoxDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  labelText: "Wähle den Abfahrtsbahnhof",
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 7,
              child: DropdownSearch<Station>(
                mode: Mode.BOTTOM_SHEET,
                maxHeight: 300,
                items: stations,
                selectedItem: _destinationStation,
                label: "Ziel",
                onChanged: (dynamic value) {
                  setState(() => _destinationStation = value);
                },
                showSearchBox: true,
                searchBoxDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  labelText: "Wähle den Zielbahnhof",
                ),
              ),
            ),
          ]),
          departureList(_data)
        ]));
  }

  Widget departureList(Future<List<Departure>> departures) {
    return Container(
      height: MediaQuery.of(context).size.height / 5 * 3.2,
      child: StreamProvider<List<Departure>>.value(
          value: Stream.fromFuture(departures), child: DepartureList()),
    );
  }
}
