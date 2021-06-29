import 'package:pendlerinfo/models/comment.dart';
import 'package:pendlerinfo/screens/comments/comment_list.dart';
import 'package:pendlerinfo/screens/timetable/comment_form.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    void _showCommentPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child:
              CommentForm(null, null, ""),
            );
          });
    }

    return StreamProvider<List<Comment>>.value(
      initialData: [],
      value: Stream.fromFuture(fetchComments()),
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text('Pendlerinfo - Kommentare'),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_comment_rounded),
              color: Colors.white,
              tooltip: 'Sag was zu den anderen Pendlern',
              onPressed: () => _showCommentPanel(),
            )
          ]
        ),
        body: Container(
          child: CommentsList()
        ),
      ),
    );
  }
}