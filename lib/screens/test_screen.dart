import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

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

  int questionLeft = 10;
  int questionRight = 5;
  String operator = "+";
  String answerString = "";

  bool isCalcButtonsEnabled = false;
  bool isAnswerCheckButtonEnabled = false;
  bool isBackButtonEnabled = false;
  bool isCorrectInCorrectImageEnabled = false;
  bool isEndMessageEnabled = false;
  bool isCorrect = false;

  Soundpool soundpool;

  int soundIdCorrect = 0;
  int soundIdInCorrect = 0;

  @override
  void initState() {
    super.initState();
    numberOfCorrect = 0;
    correctRate = 0;
    numberOfRemaining = widget.numberOfQuestions;

    initSounds();

    setQuestion();
  }

  Future<void> initSounds() async {
    try {
      soundpool = Soundpool();
      soundIdCorrect = await loadSound("assets/sounds/sound_correct.mp3");
      soundIdInCorrect = await loadSound("assets/sounds/sound_incorrect.mp3");
      setState(() {});
    } on IOException catch (error) {
      print("エラーの内容は:$error");
    }
  }

  Future<int> loadSound(String soundPath) {
    return rootBundle.load(soundPath).then((value) => soundpool.load(value));
  }

  @override
  void dispose() {
    super.dispose();
    soundpool.release();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
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
            //〇・×画像             _correctIncorrectImage(),
            _correctIncorrectImage(),
            //テスト終了メッセージ
            _endMessage(),
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
        TableRow(
          children: [
            Text(
              numberOfRemaining.toString(),
              style: TextStyle(fontSize: 10.0),
            ),
            Text(
              numberOfCorrect.toString(),
              style: TextStyle(fontSize: 10.0),
            ),
            Text(
              correctRate.toString(),
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        ),
      ],
    );
  }

  //TODO 問題表示部分
  Widget _questionPart() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 80.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  questionLeft.toString(),
                  style: TextStyle(fontSize: 36.0),
                ),
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  operator,
                  style: TextStyle(fontSize: 30.0),
                ),
              )),
          Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  questionRight.toString(),
                  style: TextStyle(fontSize: 36.0),
                ),
              )),
          Expanded(
              flex: 1,
              child:
              Center(child: Text("=", style: TextStyle(fontSize: 30.0)))),
          Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  answerString,
                  style: TextStyle(fontSize: 60.0),
                ),
              )),
        ],
      ),
    );
  }

  //TODO  電卓ボタン部分
  Widget _calcButtons() {
    return Table(
      children: [
        TableRow(children: [
          _calcButton("7"),
          _calcButton("8"),
          _calcButton("9"),
        ]),
        TableRow(
          children: [
            _calcButton("4"),
            _calcButton("5"),
            _calcButton("6"),
          ],
        ),
        TableRow(
          children: [
            _calcButton("1"),
            _calcButton("2"),
            _calcButton("3"),
          ],
        ),
        TableRow(children: [
          _calcButton("0"),
          _calcButton("-"),
          _calcButton("C"),
        ]),
      ],
    );
  }

  Widget _calcButton(String numString) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: Colors.brown,
        onPressed: () => inputAnswer(numString), //TODO
        child: Text(
          numString,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  //TODO 答え合わせボタン
  Widget _answerCheckButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          color: Colors.cyanAccent,
          onPressed: answerCheck(),
          child: Text(
            "こたえあわせ",
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  //TODO 戻るボタン
  Widget _backButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
            color: Colors.brown,
            onPressed: null,
            child: Text(
              "もどる",
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ),
    );
  }

  //TODO 〇・バツ画像
  Widget _correctIncorrectImage() {
    if (isCorrectInCorrectImageEnabled == true) {
      if (isCorrect)
        return Center(child: Image.asset("assets/images/pic_correct.png"));
    }
        return Center(child: Image.asset("assets/images/pic_incorrect.png"));
    } else {
      return Container();
    }
  }

  //TODO テスト終了メッセージ
  Widget _endMessage() {
    if (isEndMessageEnabled) {
      return Center(
          child: Text(
            "テスト終了",
            style: TextStyle(fontSize: 50.0),
          ));
    } else {
      return Container();
    }
  }

  //TODO 問題を出す
  void setQuestion() {
    isCalcButtonsEnabled = true;
    isAnswerCheckButtonEnabled = true;
    isBackButtonEnabled = false;
    isCorrectInCorrectImageEnabled = false;
    isEndMessageEnabled = false;

    Random random = Random();
    questionLeft = random.nextInt(100) + 1;
    questionRight = random.nextInt(100) + 1;

    if (random.nextInt(2) + 1 == 1) {
      operator = "+";
    } else {
      operator = "-";
    }
  }

  inputAnswer(String numString) {
    //早期リターンを使う場合
    setState(() {
      if (numString == "C") {
        answerString = "";
        return;
      }
      if (numString == "-") {
        if (answerString == "") answerString = "-";
        return;
      }
      if (numString == "0") {
        if (answerString != "0" && answerString != "-")
          answerString = answerString + numString;
        return;
      }
      if (answerString == "0") {
        answerString = numString;
        return;
      }
      answerString = answerString + numString;
    });
  }

  answerCheck() {
    if (answerString == "" || answerString == "-") {
      return;
    }
    isCalcButtonsEnabled = false;
    isAnswerCheckButtonEnabled = false;
    isBackButtonEnabled = false;
    isCorrectInCorrectImageEnabled = true;
    isEndMessageEnabled = false;

    var myAnswer = int.parse(answerString).toInt();
    var realAnswer = 0;
    if (operator == "+") {
      realAnswer = questionLeft + questionRight;
    } else {
      realAnswer = questionLeft - questionRight;
    }

    if (myAnswer == realAnswer) {

    } else {

    }

    setState(() {});
  }
}