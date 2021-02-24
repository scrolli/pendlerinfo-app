import 'package:pendlerinfo/models/comment.dart';
import 'package:pendlerinfo/models/departure.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pendlerinfo/models/departure_time.dart';
import 'package:pendlerinfo/models/platform.dart';
import 'package:pendlerinfo/screens/timetable/comment_form.dart';
import 'package:pendlerinfo/screens/timetable/departure_comment_tile.dart';

class DepartureTile extends StatelessWidget {
  final Departure departure;

  DepartureTile({this.departure});

  @override
  Widget build(BuildContext context) {
    void _showCommentPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child:
                  CommentForm(this.departure.stopId, this.departure.number, ''),
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 0.0),
          child: Column(children: [
            Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 4.8,
                    child: Column(children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 35,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ChangedDepartureWidget(
                                        departure: departure.departure)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        departure.departure.prediction != null
                                            ? DateFormat('kk:mm').format(
                                                departure.departure.prediction)
                                            : '',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(29, 170, 202, 10),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  DateFormat('kk:mm')
                                      .format(departure.departure.planned),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [Text(departure.number)],
                      )
                    ])),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5 * 3,
                  child: Column(
                    children: [
                      //Text(departure.path.planned),
                      InfoLinesWidget(departure: departure),
                      Row(
                        children: [
                          Text(departure.destination,
                              style: TextStyle(
                                fontSize: 22,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                        child: IconButton(
                          icon: Icon(Icons.add_comment_rounded),
                          tooltip: 'Sag was zu diesem Zug',
                          onPressed: () => _showCommentPanel(),
                        ))
                  ],
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        SizedBox(
                            height: 20,
                            child: Text(
                              departure.featuredDestination.arrival != null
                                  ? DateFormat('kk:mm').format(
                                      departure.featuredDestination.arrival)
                                  : '',
                              style: TextStyle(fontSize: 10),
                            )),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.width / 12,
                            child: PlatformWidget(platform: departure.platform))
                      ],
                    )
                  ],
                )
              ],
            ),
            CommentsWidget(comments: departure.comments)
          ])),
    );
  }
}

class PlatformWidget extends StatelessWidget {
  final Platform platform;

  PlatformWidget({this.platform});

  @override
  Widget build(BuildContext context) {
    if (platform.changed > 0) {
      return Text(
        platform.changed.toString(),
        style: TextStyle(
            color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),
      );
    }
    return Text(
      platform.planned.toString(),
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}

class ChangedDepartureWidget extends StatelessWidget {
  final DepartureTime departure;

  ChangedDepartureWidget({this.departure});

  @override
  Widget build(BuildContext context) {
    if (departure.changed != null &&
        departure.changed.isAfter(departure.planned)) {
      return Text(
        DateFormat('kk:mm').format(departure.changed),
        style: TextStyle(color: Colors.red, fontSize: 12),
      );
    } else if (departure.changed != null) {
      return Text(DateFormat('kk:mm').format(departure.changed),
          style: TextStyle(color: Colors.grey, fontSize: 12));
    } else {
      return Text('');
    }
  }
}

class InfoLinesWidget extends StatelessWidget {
  final Departure departure;

  InfoLinesWidget({this.departure});

  @override
  Widget build(BuildContext context) {
    String notLeft = '';
    String left = '';
    String reason = '';
    //String pth = '';
    if (departure.status.left) {
      left = 'abgefahren!';
    } else if (DateTime.now()
        .add(Duration(minutes: -1))
        .isAfter(departure.departure.changed ?? departure.departure.planned)) {
      notLeft = 'Zug noch da!';
    }
    if (departure.status.reason != null && departure.status.reason.length > 0) {
      reason = departure.status.reason;
    } else {
      //pth = departure.path.planned.substring(0,50);
    }
    return SizedBox(
        width: 600,
        height: 30,
        child: Row(children: [
          Text(
            notLeft,
            style: TextStyle(
                color: Color.fromRGBO(29, 170, 202, 10),
                fontWeight: FontWeight.bold),
          ),
          Text(left,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          SizedBox(
              width: 240,
              height: 30,
              child: Text(reason,
                  overflow: TextOverflow.clip,
                  textWidthBasis: TextWidthBasis.parent,
                  maxLines: 3,
                  style: TextStyle(color: Colors.red, fontSize: 12))),
          Flexible(child: Text(' ', overflow: TextOverflow.fade))
          //Flexible(child: Text(pth, overflow: TextOverflow.fade))
        ]));
  }
}

class CommentsWidget extends StatelessWidget {
  final List<Comment> comments;

  CommentsWidget({this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.length < 1) {
      return Container();
    }
    return Container(
      color: Colors.grey[800],
      child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: List<Widget>.from(comments
                .map((c) => new DepartureCommentTile(comment: c))
                .toList()),
          )),
    );
  }
}
