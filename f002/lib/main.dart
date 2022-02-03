import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //final randomWord = WordPair.random();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScaffoldSample(),
    );
  }
}

class ScaffoldSample extends StatefulWidget{
  @override
  _ScaffoldSampleState createState() => _ScaffoldSampleState();
  
}

class _ScaffoldSampleState extends State<ScaffoldSample>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          title: Text
        ("해커톤 테스트",
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.grey,
      ),

      body: Center(
        child: Text("시각 장애인분들을 위한 어플",style: TextStyle(fontSize: 20),),
      ),

      drawer: Drawer(
        child: Center(
          child: Text("슬라이드 메뉴"),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index){
          print(index);
        },
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Test1"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Test2")
        ],
      ),
    );

  }
}
