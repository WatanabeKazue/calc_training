import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DropdownMenuItem<int>> _menuItem = List();

  @override
  void initState() {
    super.initState();
   setMenuItems();
  }

  void setMenuItems() {
    _menu
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
                SizedBox(height: 15.0,),

                Text(
                    "問題数を選択して「スタート」ボタンを押してください。",
                    style: TextStyle(fontSize: 13.0),
                ),
               SizedBox(height: 50.0,),
                DropdownButton(
                items: [
                  DropdownMenuItem(child: null),
                  DropdownMenuItem(child: null),
                  DropdownMenuItem(child: null),
                ],
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
                      onPressed: () => print("Button is OK"),
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


}
