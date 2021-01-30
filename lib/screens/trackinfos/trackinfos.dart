import 'package:pendlerinfo/models/trackinfos.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackinfosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<Trackinfos>.value(
      value: Stream.fromFuture(fetchTrackinfos()),
      child: Scaffold(
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
          title: Text('Pendlerinfo'),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        body: Container(
          child: Text('Trackinfos')
        ),
      ),
    );
  }
}