import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  var data = [
    Sales("sun", 50),
    Sales("mon", 70),
    Sales("tue", 100),
    Sales("wed", 50),
    Sales("thu", 145),
    Sales("fri", 190),
    Sales("sat", 300),];



  @override
  Widget build(BuildContext context) {

    var series = [
      charts.Series(
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sold,
        id: "Sales",
        data: data,
        labelAccessorFn: (Sales sales, _) => "${sales.day}, ${sales.sold.toString()}",
      )
    ];

    var barChart = charts.BarChart(
      series,
    );

    var pieChart = charts.PieChart(
      series,
      defaultRenderer: charts.ArcRendererConfig(
        arcRendererDecorators: [charts.ArcLabelDecorator()],
      ),
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("차트"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: barChart,
                  ),
                  Expanded(
                    flex: 1,
                    child: pieChart,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sales{
  final String day;
  final int sold;

  Sales(this.day, this.sold);
}
