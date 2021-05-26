import 'package:calc_training/screens/test_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DropdownMenuItem<int>> _menuItem = [];
  int _numberOfQuestions = 0;

  @override
  void initState() {
    super.initState();
    setMenuItems();
    _numberOfQuestions = _menuItem[0].value;
    //_numberOfQuestions = _menuItem[0].value!;
  }

  void setMenuItems() {
    //TODO 明日はここから
    _menuItem.add(DropdownMenuItem(
      value: 10,
      child: Text(10.toString()),
    ));
    _menuItem.add(DropdownMenuItem(
      value: 20,
      child: Text(20.toString()),
    ));
    _menuItem.add(DropdownMenuItem(
      value: 30,
      child: Text(30.toString()),
    ));

    // _menuItem
    //   ..add(DropdownMenuItem(
    //     value: 10,
    //     child: Text(10.toString()),
    //   ))
    //   ..add(DropdownMenuItem(
    //     value: 20,
    //     child: Text(20.toString()),
    //   ))
    //   ..add(DropdownMenuItem(
    //     value: 30,
    //     child: Text(30.toString()),
    //   ));
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    print("ヨコ幅の論理ピクセル :$screenWidth");
    print("タテ幅の論理ピクセル :$screenHeight");

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[

                Image.asset("assets/images/image_title.png"),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  "問題数を選択して「スタート」ボタンを押してください。",
                  style: TextStyle(fontSize: 13.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
                DropdownButton(
                  items: _menuItem,
                  value: _numberOfQuestions,
                  onChanged: (int selectedValue) {
                    _numberOfQuestions = selectedValue;
                  },
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton.icon(
                      //color: Colors.blue,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all((Radius.circular((10.0)))),
                          ))),
                      onPressed: () => startTestScreen(context),
                      label: Text("START"),
                      icon: Icon(Icons.skip_next),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  changeDropDownItem(int value) {
    setState(() {
      _numberOfQuestions = value;
    });
  }

  startTestScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            //       builder: (context) =>
            //          TestScreen(numberOfQuestions: _numberOfQuestions,
            //          ))
            builder: (context) => TestScreen(
                  numberOfQuestions: _numberOfQuestions,
                )));
  }


}
