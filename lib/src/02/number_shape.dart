import 'package:flutter/material.dart';
import 'dart:math';

class Number_Shape extends StatefulWidget {
  const Number_Shape({Key? key}) : super(key: key);

  @override
  _Number_ShapeState createState() => _Number_ShapeState();
}

class _Number_ShapeState extends State<Number_Shape> {
  final fieldText = TextEditingController();
  String? _number;
  String? _out_message = "";

  void verifyNumber() {
    bool isSquare = false;
    bool isTriangular = false;
    if (isInteger(sqrt(int.parse(_number.toString())))) {
      isSquare = true;
    }
    if (perfectCube(int.parse(_number.toString()))) {
      isTriangular = true;
    }

    if (isSquare && isTriangular) {
      _out_message = "Number $_number is SQUARE and \nTRIANGULAR";
    } else if (isSquare) {
      _out_message = "Number $_number is SQUARE ";
    } else if (isTriangular) {
      _out_message = "Number $_number is TRIANGULAR ";
    } else {
      _out_message = "Number $_number is neither SQUARE or \nTRIANGULAR";
    }
  }

  bool perfectCube(int N) {
    int cube;
    for (int i = 1; i <= N; i++) {
      cube = i * i * i;

      if (cube == N) {
        return true;
      } else if (cube > N) {
        return false;
      }
    }
    return false;
  }

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.verified_user_outlined),
        backgroundColor: Colors.green,
        onPressed: () {
          if (int.tryParse(_number.toString()) != null) verifyNumber();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(_number.toString()),
              content: Text(_out_message.toString()),
            ),
          );
          fieldText.clear();
        },
      ),
      appBar: AppBar(
        title: Text("Number Shapes"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Text(
                  "Please input a number to see if it is square or triangular",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: fieldText,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _number = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
