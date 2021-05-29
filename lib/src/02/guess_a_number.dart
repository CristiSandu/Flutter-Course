import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_course/src/02/number_shape.dart';

void main() {
  runApp(const MaterialApp(
    home: GuessANumber(),
  ));
}

class GuessANumber extends StatefulWidget {
  const GuessANumber({Key? key}) : super(key: key);

  @override
  _GuessANumberState createState() => _GuessANumberState();
}

class _GuessANumberState extends State<GuessANumber> {
  String? _number;

  static Random random = Random();
  int randomNumber = random.nextInt(100) + 1;
  String? verdict = '';
  String? buttonText = 'Guess';
  String? tried = '';

  final TextEditingController fieldText = TextEditingController();

  void resetField() {
    buttonText = 'Guess';
    randomNumber = random.nextInt(100) + 1;
    verdict = '';
    _number = '';
    tried = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute<NumberShape>(builder: (BuildContext context) => const NumberShape()));
        },
        child: const Icon(Icons.arrow_right),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        title: const Text('Guess my number'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.red,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Text(
                      "I'm thinking of a number between \n 1 and 100.",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      "It's your turn to guess my number!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (verdict != '')
                    Text(
                      tried.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                  if (verdict != '')
                    Text(
                      verdict.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Material(
                      elevation: 6.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Try a number!',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                            child: TextField(
                              controller: fieldText,
                              keyboardType: TextInputType.number,
                              onChanged: (String value) {
                                _number = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  print(randomNumber);
                                  fieldText.clear();
                                  if (buttonText == 'Reset') {
                                    resetField();
                                  } else if (int.tryParse(_number.toString()) != null) {
                                    tried = 'You tried $_number ';
                                    final int _numberInt = int.parse(_number.toString());
                                    if (_numberInt == randomNumber) {
                                      verdict = 'You guessed right!';
                                      showDialog<TextButton>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => AlertDialog(
                                          title: const Text('You guessed right'),
                                          content: Text('It was $_number'),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    resetField();
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: const Text('Try again!')),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    buttonText = 'Reset';
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: const Text('ok'))
                                          ],
                                        ),
                                      );
                                    } else if (_numberInt < randomNumber) {
                                      verdict = 'Try Higher';
                                    } else {
                                      verdict = 'Try Lower';
                                    }
                                  }
                                });
                              },
                              child: Text(
                                buttonText.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
