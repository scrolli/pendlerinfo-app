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
              padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 60.0),
              child: CommentForm(),
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
                Column(children: [
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
                                        color: Color.fromRGBO(29, 170, 202, 10),
                                        fontWeight: FontWeight.w400))
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [Text(departure.number)],
                  )
                ]),
                SizedBox(
                  width: 240,
                  child: Column(
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
                        width: 40,
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
                            height: 30,
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
        style: TextStyle(color: Colors.red),
      );
    } else if (departure.changed != null) {
      return Text(DateFormat('kk:mm').format(departure.changed),
          style: TextStyle(color: Colors.grey));
    } else {
      return Text('');
    }
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
