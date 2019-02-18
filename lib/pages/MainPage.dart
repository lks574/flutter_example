import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("제너레이션,용산집"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              appBarAction();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            SizedBox(
              child: Container(
                color: Colors.redAccent,
                child: Text("asdasd"),
              ),
            ),
            SizedBox(
              child: Container(
                color: Colors.redAccent,
                child: Text("asdasd"),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Action
  appBarAction(){

  }
}
