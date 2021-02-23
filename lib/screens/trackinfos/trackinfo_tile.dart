import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pendlerinfo/models/trackinfo.dart';

class TrackinfoTile extends StatelessWidget {
  final Trackinfo trackinfo;

  TrackinfoTile({this.trackinfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: trackinfo.level > 1 ? Colors.white : Colors.grey[500],
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                      DateFormat('kk:mm')
                          .format(trackinfo.published),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(' | '),
                  Flexible(
                      child: Text(trackinfo.title,
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
              Row(children: [
                Flexible(
                  child: Text(trackinfo.message),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
