import 'package:pendlerinfo/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentTile extends StatelessWidget {

  final Comment comment;
  CommentTile({ this.comment });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Row(
         children: [
           Text(comment.message),
           Text(DateFormat('kk:mm dd.MM.yyyy').format(comment.published))
         ],
        )
      ),
    );
  }
}

//Text(departure.platform.planned.toString() + DateFormat('yyyy-MM-dd – kk:mm').format(departure.departure.planned))