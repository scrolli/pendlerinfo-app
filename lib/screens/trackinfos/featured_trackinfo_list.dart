import 'package:flutter/material.dart';
import 'package:pendlerinfo/models/trackinfo.dart';
import 'package:pendlerinfo/screens/trackinfos/trackinfo_tile.dart';
import 'package:provider/provider.dart';

class FeaturedTrackinfoList extends StatefulWidget {
  @override
  _FeaturedTrackinfoListState createState() => _FeaturedTrackinfoListState();
}

class _FeaturedTrackinfoListState extends State<FeaturedTrackinfoList> {
  @override
  Widget build(BuildContext context) {

    final trackinfos = Provider.of<List<Trackinfo>>(context) ?? [];

    var featuredTrackinfos = trackinfos.where((i) => i.featured == true).toList();
    if (featuredTrackinfos.length < 1) {
      return Flexible(child: Text('derzeit keine Meldungen'));
    }
    return ListView.builder(
      itemCount: featuredTrackinfos.length,
      itemBuilder: (context, index) {
        return TrackinfoTile(trackinfo: featuredTrackinfos[index]);
      },
    );
  }

}