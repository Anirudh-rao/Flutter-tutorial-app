import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/Services/Auth.dart';

class HomePage extends StatelessWidget {
  HomePage({
    @required this.auth,
  });

  final Authbase auth;

  // ignore: missing_return
  Future<Void> _signOut() async {
    try {
      await auth.signOut(); // we need to call the Onsignout Constructor
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
