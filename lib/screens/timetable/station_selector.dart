import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pendlerinfo/models/departure.dart';
import 'package:pendlerinfo/models/station.dart';
import 'package:pendlerinfo/screens/timetable/departure_tile.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StationSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StationSelectorState();
}

class _StationSelectorState extends State<StationSelector> {
  UniqueKey depKey = UniqueKey();
  UniqueKey destKey = UniqueKey();

  SharedPreferences prefs;
  Station _departureStation;
  Station _destinationStation;
  List<Departure> departures;

  @override
  Widget build(BuildContext context) {
    final stations = Provider.of<List<Station>>(context) ?? [];

    if (_departureStation == null) {
      int depEva = prefs.getInt('departure_eva') ?? 8000261;
      _departureStation = stations.where((s) => s.eva == depEva).first;
    }
    if (_destinationStation == null) {
      int destEva = prefs.getInt('destination_eva') ?? 8003982;
      _destinationStation = stations.where((s) => s.eva == destEva).first;
    }

    fetchDepartureList();

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 10,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: DropdownSearch<Station>(
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 300,
              items: stations,
              selectedItem: _departureStation,
              label: "Abfahrt",
              key: depKey,
              onChanged: (dynamic value) {
                var _prevDeparture = _departureStation;
                if (value.eva == _destinationStation.eva) {
                  _destinationStation = _prevDeparture;
                }
                _departureStation = value;
                setState(() => refreshStations());
              },
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Wähle den Abfahrtsbahnhof",
              ),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 10,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: DropdownSearch<Station>(
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 300,
              items: stations,
              selectedItem: _destinationStation,
              label: "Ziel",
              key: destKey,
              onChanged: (dynamic value) {
                var _prevDestination = _destinationStation;
                if (value.eva == _departureStation.eva) {
                  _departureStation = _prevDestination;
                }
                _destinationStation = value;
                setState(() => refreshStations());
              },
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Wähle den Zielbahnhof",
              ),
            ),
          ),
        ),
      ]),
      Container(
        color: Colors.white ,
          child:Row(children: [
        IconButton(
          highlightColor: Colors.grey,
            color: Colors.blue,
            icon: Icon(Icons.switch_right_sharp),
            onPressed: () {
              setState(() {
                toggle();
              });
            })
      ]),
      ),
      Container(
          height: MediaQuery.of(context).size.height / 5 * 3.4,
          child: RefreshIndicator(
              child: ListView.builder(
                itemCount: departures.length,
                itemBuilder: (context, index) {
                  return DepartureTile(
                      departure: departures[index], station: _departureStation);
                },
              ),
              onRefresh: () => _getData()))
    ]);
  }

  void refreshStations() async {
    // set value
    prefs.setInt('departure_eva', _departureStation.eva);
    prefs.setInt('destination_eva', _destinationStation.eva);

    depKey = UniqueKey();
    destKey = UniqueKey();
  }

  void toggle() {
    var olddep = this._departureStation;
    this._departureStation = this._destinationStation;
    this._destinationStation = olddep;
    refreshStations();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchPreferences();
    fetchDepartureList();
  }

  void fetchPreferences() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  void fetchDepartureList() async {
    var _dep =
        await fetchDepartures(_departureStation.eva, _destinationStation);
    setState(() {
      departures = _dep;
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchDepartureList();
    });
  }
}