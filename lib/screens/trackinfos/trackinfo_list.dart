import 'package:flutter/material.dart';
import 'package:pendlerinfo/models/trackinfo.dart';
import 'package:pendlerinfo/screens/trackinfos/trackinfo_tile.dart';
import 'package:provider/provider.dart';

class TrackinfoList extends StatefulWidget {
  @override
  _TrackinfoListState createState() => _TrackinfoListState();
}

class _TrackinfoListState extends State<TrackinfoList> {
  @override
  Widget build(BuildContext context) {

    final trackinfos = Provider.of<List<Trackinfo>>(context) ?? [];

    var unfeaturedTrackinfos = trackinfos.where((i) => i.featured == false).toList();
    if (unfeaturedTrackinfos.length < 1) {
      return ListView();
    }
    return ListView.builder(
      itemCount: unfeaturedTrackinfos.length,
      itemBuilder: (context, index) {
        return TrackinfoTile(trackinfo: unfeaturedTrackinfos[index]);
      },
    );
  }

}