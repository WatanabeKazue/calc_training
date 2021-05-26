import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  final numberOfQuestions;

  TestScreen({@required this.numberOfQuestions});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int numberOfRemaining = 0;
  int numberOfCorrect = 0;
  int correctRate = 0;

  int questionLeft = 0;
  int questonRigt = 0;
    String operator = "";
    String answerString = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _scorePart(),
            //問題表示部分
            _questionPart(),
            //電卓ボタン部分
            _calcButtons(),
            //答え合わせボタン
            _answerCheckButton(),
            //戻るボタン
            _backButton(),
          ],
        ),
      ),
    );
  }

  //TODO スコア表示部分
  Widget _scorePart() {
    return Table(
      children: [
        TableRow(children: [
          Text(
            "のこり問題数",
            style: TextStyle(fontSize: 10.0),
          ),
          Text(
            "正解数",
            style: TextStyle(fontSize: 10.0),
          ),
          Text(
            "正答率",
            style: TextStyle(fontSize: 10.0),
          ),
        ]),
        TableRow(children: [
          Text(
            numberOfRemaining.toString(),
            style: TextStyle(fontSize: 10.0),
          ),
          Text(
            numberOfRemaining.toString(),
            style: TextStyle(fontSize: 10.0),
          ),
          Text(
            numberOfRemaining.toString(),
            style: TextStyle(fontSize: 10.0),
          ),
        ],),
      ],
    );
  }

  //TODO 問題表示部分
  Widget _questionPart() {
    return Row(
      children: <Widget>[
        Text(questionLeft.toString(),style:TextStyle(fontSize: 36.0),),
        Text(operator,style: TextStyle(fontSize: 30.0),),
        Text(questionLeft.toString(),style:TextStyle(fontSize: 36.0),),
        Text("=",style:TextStyle(fontSize: 30.0)),
        Text(answerString,style: TextStyle(fontSize: 60.0),),
      ],
    );
  }

  //TODO  電卓ボタン部分
  Widget _calcButtons() {
    return Table(
      children: [TableRow()],
    );
  }

  //TODO 答え合わせボタン
  Widget _answerCheckButton() {
    return Table(
      children: [TableRow()],
    );
  }

  //TODO 戻るボタン
  Widget _backButton() {
    return Table(
      children: [TableRow()],
    );
  }
}
