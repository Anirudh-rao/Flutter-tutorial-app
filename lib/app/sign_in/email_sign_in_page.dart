import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/Services/Auth.dart';

import 'EmailSignInForm.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({@required this.auth});

  final Authbase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(auth: auth),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
