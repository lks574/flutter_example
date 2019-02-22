import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookPage extends StatefulWidget {
  @override
  _FacebookPageState createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';


  Future<Null> _login() async {
    final FacebookLoginResult result = await facebookSignIn.logInWithReadPermissions(['email']);

    switch (result.status){
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage(""""
        Logged in!
        
        Token: ${accessToken.token}
        UserID: ${accessToken.userId}
        Expires: ${accessToken.permissions}
        Permission: ${accessToken.permissions}
        Delined Permission: ${accessToken.declinedPermissions}
        """);
        break;

      case FacebookLoginStatus.cancelledByUser:
        _showMessage("Login cancelled by the user.");
        break;

      case FacebookLoginStatus.error:
        _showMessage("Something went wrong with the login process.\n"
            "Here\'s the error Facebook gave us : ${result.errorMessage}");
        break;
    }
  }


  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage("Logged out.");
  }

  _showMessage(String message){
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("페이스북"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_message),
            RaisedButton(
              onPressed: _login,
              child: Text("Log in"),
            ),
            RaisedButton(
              onPressed: _logOut,
              child: Text("Log out"),
            )
          ],
        ),
      ),
    );
  }
}
