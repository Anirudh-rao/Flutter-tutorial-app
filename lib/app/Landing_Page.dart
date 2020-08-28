import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/Services/Auth.dart';
import 'package:time_tracker_flutter_course/app/Home_Page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});

  final Authbase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          snapshot.hasError;
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: auth,
              );
            }
            return HomePage(
              auth: auth,
              // to make Update user as  null
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
