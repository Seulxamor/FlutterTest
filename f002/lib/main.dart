import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer1 = AudioPlayer();
AudioPlayer audioPlayer2 = AudioPlayer();

//시작 시 출력 되는 음성 가이드 함수
play() async {
  int result = await audioPlayer1
      .play('http://220.69.209.111:8000/media/uploads/music/start.mp3');

  if (result == 1) {
    print("success");
  } else {
    print("error");
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Do_not_worry',
      home: scanFun(), //시작 화면을 지정
    );
  }
}

//시각장애인 분들을 위한 기능 (책이나 문서 등을 스캔하여 서버에 전달)
class scanFun extends StatefulWidget {
  @override
  _scanFunState createState() => _scanFunState();
}

class _scanFunState extends State<scanFun> {
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
    play();
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Do_not_worry',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Jua',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 240, 55, 22),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image == null
                  ? Text(
                      '화면 터치',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Jua',
                      ),
                    )
                  : Image.file(temp)
            ],
          ),
        ),
      ),
      onTap: () async {
        image = await _picker.pickImage(source: ImageSource.camera);

        var request = http.MultipartRequest(
            'POST', Uri.parse('http://220.69.209.111:8000/image/'));
        request.files
            .add(await http.MultipartFile.fromPath('image', image!.path));

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var text = await response.stream.bytesToString();
          Map<String, dynamic> responseJson = jsonDecode(text);
          var audio_path = responseJson['audio_path'];
          var response_text = responseJson['text'];
          print(audio_path);
          print(response_text);

          play2() async {
            int result = await audioPlayer2.play(audio_path);

            if (result == 1) {
              print("success");
            } else {
              print("error");
            }
          }

          play2();
        } else {
          print(response.reasonPhrase);
        }
      },
    );
  }
}

mixin FF5C4B {}
