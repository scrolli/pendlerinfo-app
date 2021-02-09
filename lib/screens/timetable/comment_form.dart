import 'package:flutter/material.dart';

class CommentForm extends StatefulWidget {
  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _number;
  String _message;

  @override
  Widget build(BuildContext context) {

    return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Deine Meldung zum Zug',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  initialValue: _message,
                  //decoration: textInputDecoration,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 3,
                  validator: (val) => val.isEmpty ? 'Bitte gib einen Kommentar ein' : null,
                  onChanged: (val) => setState(() => _message = val),
                ),
                SizedBox(height: 60.0),
                RaisedButton(
                  color: Colors.blue[900],
                  child: Text(
                    'Veröffentlichen',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      /*await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? snapshot.data.sugars, 
                        _currentName ?? snapshot.data.name, 
                        _currentStrength ?? snapshot.data.strength
                      );*/
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          );
  }
}