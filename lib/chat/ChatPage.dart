import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'dart:async';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final googleSignIn = new GoogleSignIn();
//  final analytics = new FirebaseAnalytics();
  final auth = FirebaseAuth.instance;
  var currentUserEmail;
  var _scaffoldContext;


  _signOut() async{
    await auth.signOut();
    googleSignIn.signOut();
    Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(content: Text("User logged out")));
  }



  // 로그인 상태 체크
  Future<Null> _ensureLoggedIn() async {

    /*
     * 구글 로그인 체크
     * GoogleService-info 넣기
     * plist 추가
     */

    GoogleSignInAccount signedInUser = googleSignIn.currentUser;
    if (signedInUser == null){
      signedInUser = await googleSignIn.signInSilently();
    }
    if (signedInUser == null){
      await googleSignIn.signIn();
//      analytics.logLogin();
    }

    currentUserEmail = googleSignIn.currentUser.email;

    /*
     * firebase auth 구글 추가
     * firebase auth google 활성화하기
     */
    if (await auth.currentUser() == null){
      GoogleSignInAuthentication credentials = await googleSignIn.currentUser.authentication;
      AuthCredential authCredential = GoogleAuthProvider.getCredential(idToken: credentials.idToken, accessToken: credentials.accessToken);
      await auth.signInWithCredential(authCredential);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Chat"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app,),
            onPressed: _signOut,
          ),

          IconButton(
            icon: Icon(Icons.assignment_ind),
            onPressed: () async {
              await _ensureLoggedIn();
            },
          )
        ],
      ),
    );
  }
}
