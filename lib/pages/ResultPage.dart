import 'package:flutter/material.dart';
import 'package:flutter_example/models/DefaultData.dart';
import 'package:flutter_example/models/NameModel.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';

class ResultPage extends StatefulWidget {
  ResultPage(this.names, this.cleanNumber);

  final List<NameModel> names;
  final List<int> cleanNumber;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  List<String> _nameList;
  List<int> _cleanList;
  List<String> _randomResult = List();
  final _cleanPosition = DefaultData.cleanList;

  String _sharedText = "";

  @override
  void initState() {
    super.initState();
    _nameList = widget.names.map((model) => model.name).toList();
    _cleanList = widget.cleanNumber;
    _listSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("결과창"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
              _shareText();
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text("${_nameList[index]} - ${_randomResult[index]}"),
            );
          },
          itemCount: _nameList.length,
        ),
      ),
    );
  }


  _listSetting(){
    List.generate(_cleanList.length, (index){
      int asd = _cleanList[index];
      while ( asd > 0 ){
        _randomResult.add(_cleanPosition[index]);
        asd--;
      }
    });

    int minus = _nameList.length - _randomResult.length;
    while ( minus > 0 ){
      _randomResult.add("휴식");
      minus--;
    }

    _randomResult.shuffle();

    setState(() {});
  }

  Future _shareText() async {

    _sharedSetting();

    try {
      // 안드로이드의 경우 title이 있음.
      await EsysFlutterShare.shareText(_sharedText, '청소 공유');
    } catch (e) {
      print('error: $e');
    }
  }

  _sharedSetting(){
    _nameList.asMap().forEach((index, data){
      _sharedText += "$data-${_randomResult[index]}";
      if (index != _nameList.length-1){
        _sharedText += "\n";
      }
    });

//    List.generate(_nameList.length, (index){
//      int totalNumber = _nameList.length;
//      while (totalNumber > 0){
//        _sharedText += "${_nameList[index]} - ${_randomResult[index]}";
//        totalNumber--;
//      }
//    });
  }

}
