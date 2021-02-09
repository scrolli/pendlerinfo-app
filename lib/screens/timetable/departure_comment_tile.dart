import 'package:flutter/cupertino.dart';
import 'package:pendlerinfo/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepartureCommentTile extends StatelessWidget {
  final Comment comment;

  DepartureCommentTile({this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Row(children: [
            Flexible(
              child: Text(
                comment.message + '             ',
                  style:  TextStyle(
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            Text(DateFormat('kk:mm').format(comment.published),
                textAlign: TextAlign.right
            )
          ]),
        ),
      ),
    );
  }
}