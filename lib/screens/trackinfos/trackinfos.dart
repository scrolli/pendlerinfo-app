import 'package:pendlerinfo/models/trackinfo.dart';
import 'package:pendlerinfo/screens/trackinfos/featured_trackinfo_list.dart';
import 'package:pendlerinfo/screens/trackinfos/trackinfo_list.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackinfosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Trackinfo>>.value(
      value: Stream.fromFuture(fetchTrackinfos()),
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text('Pendlerinfo - Streckeninfos'),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(children: <Widget>[
            Container(
                color: Colors.white70,
                height: MediaQuery.of(context).size.height / 5,
                child: FeaturedTrackinfoList()),
            Container(
                height: MediaQuery.of(context).size.height / 5 * 3,
                child: TrackinfoList()
            )
          ]),
        ),
      ),
    );
  }
}
