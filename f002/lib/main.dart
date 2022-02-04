import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import "package:http/http.dart" as htpp;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hackathon',
      home: MyButtons(
        title: 'main',
      ),
    );
  }
}

class ScaffoldSample extends StatefulWidget {
  @override
  _ScaffoldSampleState createState() => _ScaffoldSampleState();
}

class _ScaffoldSampleState extends State<ScaffoldSample> {
  late ImagePicker _picker;
  XFile? image = null;
  late File temp;

  @override
  void initState() {
    _picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image == null
                  ? Text(
                      '화면터치',
                      style: TextStyle(fontSize: 41),
                    )
                  : Image.file(temp)
            ],
          ),
        ),
      ),
      onTap: () async {
        image = await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          setState(() {
            temp = File(image!.path);
          });
        }
      },
    );
  }
}

class MyButtons extends StatefulWidget {
  const MyButtons({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyButtons> createState() => _MyButtons();
}

class _MyButtons extends State<MyButtons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 500,
                width: 500,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ScaffoldSample()));
                        },
                        child: Text(
                          '시각장애인',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.black, minimumSize: Size(0, 300)),
                      ),
                    ),
                  ],
                ),
                color: Color.fromARGB(255, 84, 143, 182),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  height: 500,
                  width: 500,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            print('청각장애인');
                          },
                          child: Text(
                            '청각장애인',
                            style: TextStyle(fontSize: 30.0),
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.black, minimumSize: Size(0, 300)),
                        ),
                      ),
                    ],
                  ),
                  color: Color.fromARGB(255, 231, 91, 91)),
            ),
          ],
        ),
      ),
    );
  }
}
