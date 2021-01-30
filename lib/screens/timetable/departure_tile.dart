import 'package:pendlerinfo/models/departure.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepartureTile extends StatelessWidget {

  final Departure departure;
  DepartureTile({ this.departure });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Row(
         children: [
           Column(
             children: [
               Row(
                 children: [
                   Column(
                     children: [
                       Row(
                         children: [
                           Text('17:02')
                         ],
                       ),
                       Row(
                         children: [
                           Text('17:05')
                         ],
                       )
                     ],
                   ),
                   Column(
                     children: [
                       Text(DateFormat('kk:mm').format(departure.departure.planned))
                     ],
                   )
                 ],
               ),
               Row(
                 children: [
                   Text(departure.number)
                 ],
               )
             ]
           ),
           Column(
             children: [
               Row(
                  children: [
                    Text(departure.status.reason ?? ''),
                ],
               ),
               Row(
                 children: [
                   Text(''),
                 ],
               ),
               Row(
                 children: [
                   Text(departure.destination)
                 ],
               )
             ],
           ),
           Column(
             children: [
               Icon(Icons.add_comment_rounded)
             ],
           ),
           Column(
             children: [
               Row(
                 children: [
                   Text(departure.featuredDestination.name + " " + DateFormat('kk:mm').format(departure.featuredDestination.arrival ?? DateTime.now()))
                 ],
               ),
               Row(
                 children: [
                   Text(departure.platform.planned.toString())
                 ],
               )
             ],
           )
         ],
        )
      ),
    );
  }
}

//Text(departure.platform.planned.toString() + DateFormat('yyyy-MM-dd – kk:mm').format(departure.departure.planned))