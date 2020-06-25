import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text(
              '휴대폰 정보',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text('스토리지',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ))),
                  Card(
                    child: Column(children: <Widget>[
                      buildText('사용 공간 : '),
                      buildText('남은 공간 : '),
                      buildText('읽기 쓰기 속도: '),
                    ]),
                  ),
                  Center(
                      child: Text('규격',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ))),
                  Card(
                    child: Column(
                      children: <Widget>[
                        buildText('모델 :'),
                        buildText('모델번호 : '),
                        buildText('사이즈 및 용량 : '),
                        buildText('시스템 번전 : '),
                        buildText('화면 사이즈 : '),
                        buildText('화면 해상도 : ')
                      ],
                    ),
                  ),
                  Center(
                      child: Text('배터리',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black))),
                  Card(
                    child: Row(
                      children: <Widget>[
                        buildButton1('사용 가능 시간', 'XX시 XX분'),
                        buildButton1('남은 충전 시간', 'XX시 XX분'),
                        buildButton1('충전 유무', 'O')
                      ],
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
  Widget buildText(String text) {
    return Container(
      alignment: Alignment(-1.0, 0.0),
      margin: EdgeInsets.all(3.0),
      child: Text(text),
    );
  }

  Widget buildButton1(String text, String text2) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
          child: new CircularPercentIndicator(
            radius: 110.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 10.0,
            percent: 0.7,
            center: new Text(text2,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),

            footer: new Text(text,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: Colors.grey,
            progressColor: Colors.red,
          )),
    );
  }
}