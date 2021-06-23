import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TicTac(),
  ));
}

class TicTac extends StatefulWidget {
  const TicTac({Key? key}) : super(key: key);

  @override
  _TicTacState createState() => _TicTacState();
}

class PositionTicTacToe {
  int used = 0;
  Color? color = Colors.white;
}

class ValidationPoss {
  ValidationPoss(this.pos1, this.pos2, this.pos3);

  int pos1 = 0;
  int pos2 = 0;
  int pos3 = 0;
}

class _TicTacState extends State<TicTac> {
  List<PositionTicTacToe> content =
      List<PositionTicTacToe>.generate(9, (_) => PositionTicTacToe());
  List<ValidationPoss> valPos = <ValidationPoss>[
    ValidationPoss(0, 1, 2),
    ValidationPoss(3, 4, 5),
    ValidationPoss(6, 7, 8),
    ValidationPoss(0, 3, 6),
    ValidationPoss(1, 4, 7),
    ValidationPoss(2, 5, 8),
    ValidationPoss(0, 4, 8),
    ValidationPoss(2, 4, 6),
  ];
  String? whoWon ;
  int personToMove = 1;

  Color? isEnd() {
    for (int i = 0; i < valPos.length; i++) {
      if (content[valPos[i].pos1].color == content[valPos[i].pos2].color &&
          content[valPos[i].pos2].color == content[valPos[i].pos3].color)
        return content[valPos[i].pos1].color;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'TicTacToe',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellow,
        ),
        body: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Colors.black54),
                ),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(content[index].color)),
                  child: Text(content[index].used.toString(),
                      style: const TextStyle(color: Colors.black54)),
                  onPressed: () {
                    setState(() {
                      print(index);
                      if (personToMove == 1 && content[index].used == 0) {
                        content[index].color = Colors.green;
                        content[index].used = 1;
                        personToMove = 0;
                      } else if (content[index].used == 0) {
                        content[index].color = Colors.red;
                        content[index].used = 1;
                        personToMove = 1;
                      }
                      final Color? outEnd = isEnd();
                      if (outEnd != null) {
                        if (outEnd == Colors.green)
                          whoWon = 'green won';
                        else if (outEnd == Colors.red)
                          whoWon = 'red won';
                      }
                    });
                  },
                ),
              );
            }));
  }
}
