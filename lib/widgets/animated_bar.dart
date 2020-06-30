import 'dart:async';
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class XpHomeScreen {

  int xp = 0;

  XpHomeScreen(this.xp);

}

class AnimatedBar extends StatefulWidget {
  @override
  _AnimatedBarState createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> {

  int _count = 0;
  Timer _timer;
  List<XpHomeScreen> data = [
    XpHomeScreen(Random().nextInt(20)),
    XpHomeScreen(Random().nextInt(20)),
    XpHomeScreen(Random().nextInt(20)),
    XpHomeScreen(Random().nextInt(20)),
    XpHomeScreen(Random().nextInt(20)),
    XpHomeScreen(Random().nextInt(20)),
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        for (XpHomeScreen tmp in data) {
          tmp.xp += Random().nextInt(20) - 10;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer.isActive)
      _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<XpHomeScreen, String>> series = [
      charts.Series(
        id: "Xp",
        data: data,
        domainFn: (XpHomeScreen series, _) => "Abc",
        measureFn: (XpHomeScreen series, _) => series.xp,
        colorFn: (XpHomeScreen series, _) => charts.ColorUtil.fromDartColor(Colors.blue),
      ),
    ];
    return Container(
        height: 400,
        child: charts.BarChart(series, animate: true)
    );
    //return Text("$_count");
  }
}