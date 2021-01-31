import 'package:pendlerinfo/models/comment.dart';
import 'package:pendlerinfo/screens/comments/comment_list.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Comment>>.value(
      value: Stream.fromFuture(fetchComments()),
      child: Scaffold(
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
          title: Text('Pendlerinfo'),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        body: Container(
          child: CommentsList()
        ),
      ),
    );
  }
}