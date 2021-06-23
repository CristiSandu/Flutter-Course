import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const BasicPhrases());
}

class BasicPhrases extends StatefulWidget {
  const BasicPhrases({Key? key}) : super(key: key);

  @override
  _BasicPhrasesState createState() => _BasicPhrasesState();
}

class _BasicPhrasesState extends State<BasicPhrases> {
  String tmpFileURL = '';
  int currentIndex = -1;
  List<String> content = <String>[
    'Rum Rum',
    'Rum Rum(in France)',
    'Beep Beep',
    'Beep Beep(in France)',
    'Ciu Ciu',
    'Ciu Ciu(in France)',
    'Ciu Ciu(Magyar )',
    'Ciu Ciu(Russ)'
  ];
  List<String> tempFileURLs = <String>[];
  AudioPlayer player = AudioPlayer();

  // ignore: non_constant_identifier_names
  Future<void> AddSounds() async {
    final Directory temp = await getTemporaryDirectory();
    ByteData data;

    for (int i = 0; i < 8; i++) {
      final File tmpFile = File('${temp.path}/$i.mp3');
      final String path = 'audioAss/$i.mp3';
      data = await rootBundle.load(path);
      await tmpFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
      tmpFileURL = tmpFile.uri.toString();
      tempFileURLs.add(tmpFileURL);
    }
  }

  void _playSound() {
    tmpFileURL = tempFileURLs[currentIndex];
    player.play(tmpFileURL);
  }

  @override
  void initState() {
    super.initState();
    AddSounds();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Basic Phrases'),
        ),
        body: GridView.builder(
            itemCount: content.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 32.0,
              mainAxisSpacing: 32.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  gradient: const LinearGradient(
                    colors: <MaterialColor>[
                      Colors.red,
                      Colors.green,
                      Colors.yellow,
                    ],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  ),
                ),
                child: TextButton(
                  child: Text(content[index],
                      style: const TextStyle(color: Colors.black54)),
                  onPressed: () {
                    setState(() {
                      currentIndex = index;
                      _playSound();
                    });
                  },
                ),
              );
            }),
      ),
    );
  }
}
