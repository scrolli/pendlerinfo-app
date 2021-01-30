import 'package:pendlerinfo/models/comment.dart';
import 'package:pendlerinfo/screens/comments/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsList extends StatefulWidget {
  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {

    final comments = Provider.of<List<Comment>>(context) ?? [];

    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentTile(comment: comments[index]);
      },
    );
  }

}