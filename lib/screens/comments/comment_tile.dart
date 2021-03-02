import 'package:flutter/cupertino.dart';
import 'package:pendlerinfo/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  CommentTile({this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
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
            Text(DateFormat('HH:mm dd.MM.yyyy').format(comment.published),
                textAlign: TextAlign.right
            )
          ]),
        ),
      ),
    );
  }
}