import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_kakao_login/flutter_kakao_login.dart';

class KakaoPage extends StatefulWidget {
  @override
  _KakaoPageState createState() => _KakaoPageState();
}

class _KakaoPageState extends State<KakaoPage> {
  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();

  String _loginMessage = 'Current Not Logined :(';
  String _accessToken = '';
  String _accountInfo = '';
  bool _isLogined = false;

  List<Map<String, String>> _litems = [
    {"key": "login", "title": "Login", "subtitle": ""},
    {"key": "logout", "title": "Logout", "subtitle": ""},
    {"key": "account", "title": "Get AccountInfo", "subtitle": ""},
    {"key": "accessToken", "title": "Get AccessToken", "subtitle": ""}
  ];

  Future<Null> _login() async {
    final KakaoLoginResult result = await kakaoSignIn.logIn();
    _processLoginResult(result);
  }

  Future<Null> _logOut() async {
    final KakaoLoginResult result = await kakaoSignIn.logOut();
    _processLoginResult(result);
    _processAccountResult(null);
  }

  Future<Null> _getAccountInfo() async {
    final KakaoLoginResult result = await kakaoSignIn.getUserMe();
    if (result != null && result.status != KakaoLoginStatus.error) {
      final KakaoAccountResult account = result.account;
      _processAccountResult(account);
    }
  }

  Future<Null> _getAccessToken() async {
    final KakaoAccessToken accessToken = await (kakaoSignIn.currentAccessToken);
    if (accessToken != null) {
      final token = accessToken.token;
      _updateAccessToken("AccessToken is \n" + token);
    } else {
      _updateAccessToken("");
    }
  }

  _updateLoginMessage(String message) {
    setState(() {
      _loginMessage = message;
    });
  }

  _updateStateLogin(bool logined) {
    setState(() {
      _isLogined = logined;
    });
    if (!logined) {
      _updateAccessToken("");
      _updateAccountMessage("");
    }
  }

  _updateAccessToken(String accessToken) {
    setState(() {
      _accessToken = accessToken;
    });
  }

  _updateAccountMessage(String message) {
    setState(() {
      _accountInfo = message;
    });
  }

  _processLoginResult(KakaoLoginResult result) {
    switch (result.status) {
      case KakaoLoginStatus.loggedIn:
        _updateLoginMessage("LoggedIn by the user.");
        _updateStateLogin(true);
        break;

      case KakaoLoginStatus.loggedOut:
        _updateLoginMessage("LoggedOut by the user.");
        _updateStateLogin(false);
        break;

      case KakaoLoginStatus.error:
        _updateLoginMessage(
            "This is Kakao error message : ${result.errorMessage}");
        _updateStateLogin(false);
        break;
    }
  }

  _processAccountResult(KakaoAccountResult account) {
    if (account == null) {
      _updateAccountMessage("");
    } else {
      final userID = (account.userID == null) ? "None" : account.userID;
      final userEmail =
          (account.userEmail == null) ? "None" : account.userEmail;
      final userPhoneNumber =
          (account.userPhoneNumber == null) ? "None" : account.userPhoneNumber;
      final userDisplayID =
          (account.userDisplayID == null) ? "None" : account.userDisplayID;
      final userNickname =
          (account.userNickname == null) ? "None" : account.userNickname;
      final userProfileImagePath = (account.userProfileImagePath == null)
          ? "None"
          : account.userProfileImagePath;
      final userThumnailImagePath = (account.userThumbnailImagePath == null)
          ? "None"
          : account.userThumbnailImagePath;

      _updateAccountMessage("- ID is $userID\n"
          "- Email is $userEmail\n"
          "- PhoneNumber is $userPhoneNumber\n"
          "- DisplayID is $userDisplayID\n"
          "- Nickname is $userNickname\n"
          "- ProfileImagePath is $userProfileImagePath\n"
          "- ThumbnailImagePath is $userThumnailImagePath");
    }
  }

  _showAlert(BuildContext context, String value) {
    if (value.isEmpty) return;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Kakao Login Plugin app'),
        ),
        body: new SafeArea(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Padding(
                //padding: const EdgeInsets.only(top: 100.0),
                padding: EdgeInsets.all(0.0),
                child: IntrinsicHeight(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(children: [
                            new Container(
                              height: 45.0,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.white, width: 0.0))),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text("Kakao Login Result",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            new Container(
                              height: 250.0,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey, width: 1.0))),
                              child: new Center(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                          left: 8.0,
                                          right: 8.0),
                                      child: new Text(
                                        _loginMessage,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 10,
                                      ),
                                    ),
                                    new Container(
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                          left: 8.0,
                                          right: 8.0),
                                      child: new Text(
                                        _accountInfo,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 10,
                                      ),
                                    ),
                                    new Container(
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                          left: 25.0,
                                          right: 25.0),
                                      child: new Text(
                                        _accessToken,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ]),
                )),
            new Expanded(
              child: new ListView.builder(
                itemCount: _litems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: new Text(_litems[index]['title']),
                    subtitle: new Text(_litems[index]['subtitle']),
                    onTap: () {
                      final key = _litems[index]['key'];
                      switch (key) {
                        case "login":
                          if (!_isLogined) {
                            _login();
                          }
                          break;
                        case "logout":
                          if (_isLogined) {
                            _logOut();
                          }
                          break;
                        case "account":
                          if (!_isLogined) {
                            _showAlert(context, 'Login is required.');
                          } else {
                            _getAccountInfo();
                          }
                          break;
                        case "accessToken":
                          if (!_isLogined) {
                            _showAlert(context, 'Login is required.');
                          } else {
                            _getAccessToken();
                          }
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        )));
  }
}
