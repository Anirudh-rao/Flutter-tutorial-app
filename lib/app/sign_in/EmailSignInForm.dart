import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/Services/Auth.dart';
import 'package:time_tracker_flutter_course/common_widgets/FormSubmitButton.dart';

enum EmailSignInformType { sigIn, register }

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.auth});

  final Authbase auth;

  @override
  _EmailSignInForm createState() => _EmailSignInForm();
}

class _EmailSignInForm extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailfocusnode = FocusNode();
  final FocusNode _passwordfocusnode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;
  EmailSignInformType _formtype = EmailSignInformType.sigIn;

  void _submit() async {
    try {
      if (_formtype == EmailSignInformType.sigIn) {
        await widget.auth.SigInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.CreateUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingCommplete() {
    FocusScope.of(context).requestFocus(_passwordfocusnode);
  }

  void _toggleformType() {
    setState(() {
      _formtype = _formtype == EmailSignInformType.sigIn
          ? EmailSignInformType.register
          : EmailSignInformType.sigIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formtype == EmailSignInformType.sigIn
        ? 'Sign in '
        : 'Create an Account';
    final secondaryText = _formtype == EmailSignInformType.sigIn
        ? 'Need and account? Register'
        : 'Have an Account? Sign In';
    bool submitenabled = _email.isNotEmpty && _password.isNotEmpty;
    return [
      TextField(
        controller: _emailController,
        focusNode: _emailfocusnode,
        //to get textfield input
        decoration:
            InputDecoration(labelText: 'Email', hintText: 'Test@test.com'),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        onchanged: (email) => _updatestate(),
        textInputAction: TextInputAction.done,
        onEditingComplete: _emailEditingCommplete,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
        focusNode: _passwordfocusnode,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true, // To hide Password
      ),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitenabled ? _submit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        child: Text(secondaryText),
        onPressed: _toggleformType,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min, //Specifies how much is required
        children: _buildChildren(),
      ),
    );
  }

  void _updatestate() {
    setState(() {});
  }
}
