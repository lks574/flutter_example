import 'package:flutter/material.dart';
import 'package:flutter_example/FacebookLogin/FacebookPage.dart';
import 'package:flutter_example/charts/ChartPage.dart';
import 'package:flutter_example/chat/ChatPage.dart';
import 'package:flutter_example/kakaoLogin/KakaoPage.dart';


class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _listItems = ["차트","카카오","페이스북", "채팅"];
  final _listPages = [ChartPage(), KakaoPage(), FacebookPage(), ChatScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asd"),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index){
            return ListTile(
              title: Text(_listItems[index]),
              onTap: (){
                _pageMove(index);
              },
            );
          },
          itemCount: _listItems.length,
        ),
      ),
    );
  }

  _pageMove(int index){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => _listPages[index]));
  }
}
