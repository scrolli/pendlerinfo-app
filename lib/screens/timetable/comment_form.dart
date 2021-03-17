import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:pendlerinfo/models/comment.dart';
import 'package:pendlerinfo/services/pendlerinfo.dart';

class CommentForm extends StatefulWidget {

  final String _stopId;
  final String _number;
  final String _message;

  CommentForm(this._stopId, this._number, this._message);

  @override
  _CommentFormState createState() =>
      _CommentFormState(this._stopId, this._number, this._message);
}

class _CommentFormState extends State<CommentForm> {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final _formKey = GlobalKey<FormState>();

  // form values
  String _stopId;
  String _number;
  String _message;

  _CommentFormState(this._stopId, this._number, this._message);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Deine Meldung zum Zug ' + this._number,
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: _message,
            //decoration: textInputDecoration,
            keyboardType: TextInputType.text,
            minLines: 1,
            maxLines: 1,
            validator: (val) =>
            val.isEmpty ? 'Bitte gib einen Kommentar ein' : null,
            onChanged: (val) => setState(() => _message = val),
          ),
          SizedBox(height: 105.0),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900], // background
                onPrimary: Colors.white, // foreground
              ),
              child: Text(
                'Veröffentlichen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  final Map<String, dynamic> data = {
                    'stopId': _stopId,
                    'number': _number,
                    'message': _message,
                  };
                  analytics.logEvent(name: 'Comment created', parameters: data);
                  await putComment(Comment(
                      stopId: _stopId, number: _number, message: _message));
                  Navigator.pop(context);
                }
              }),
        ],
      ),
    );
  }
}
