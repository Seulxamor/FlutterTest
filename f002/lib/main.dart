import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

//http://220.69.209.111:8000/media/uploads/music/start.mp3

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hackathon',
      home: ScaffoldSample(),
    );
  }
}

//시각장애인
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
        appBar: AppBar(
          title: Text('Do_not_worry'),
          backgroundColor: Colors.red,
        ),
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

          AudioPlayer audioPlayer = AudioPlayer();
          //int result1 = await audioPlayer.stop();

          play() async {
            int result = await audioPlayer.play(
                'http://220.69.209.111:8000/media/uploads/music/start.mp3');

            if (result == 1) {
              // success
              print("succ");
            } else {
              print("se");
            }
          }

          play();

          // ignore: todo
          //TODO audio_path 의 url 에 접속하면 오디오 파일이 있음. 이 파일을 가져와서 플레이 시켜보기

        } else {
          print(response.reasonPhrase);
        }
      },
    );
  }
}
