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
  PositionTicTacToe(this.used, this.color, this.val);

  int used;
  Color? color;
  ValidationPoss val;
}

class ValidationPoss {
  ValidationPoss(this.pos1, this.pos2, this.pos3);

  int pos1 = 0;
  int pos2 = 0;
  int pos3 = 0;
}

class _TicTacState extends State<TicTac> {
  List<PositionTicTacToe> content = List<PositionTicTacToe>.generate(
      9, (_) => PositionTicTacToe(0, Colors.white, ValidationPoss(0, 0, 0)));
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

  String? whoWon;
  int countDraw = 0;
  int personToMove = 1;
  int endGame = 0;

  PositionTicTacToe? isEnd() {
    for (int i = 0; i < valPos.length; i++) {
      if (content[valPos[i].pos1].color == content[valPos[i].pos2].color &&
          content[valPos[i].pos2].color == content[valPos[i].pos3].color)
        return PositionTicTacToe(0, content[valPos[i].pos3].color, valPos[i]);
    }
    return (countDraw == 9)
        ? PositionTicTacToe(0, Colors.pink, ValidationPoss(0, 0, 0))
        : PositionTicTacToe(0, null, ValidationPoss(0, 0, 0));
  }

  bool resetAtWon(PositionTicTacToe whoWon) {
    for (int i = 0; i < content.length; i++) {
      if (i != whoWon.val.pos1 &&
          i != whoWon.val.pos2 &&
          i != whoWon.val.pos3) {
        content[i].color = Colors.white;
        content[i].used = 0;
      }
    }
    return true;
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Item(
                    backColor: content[index].color,
                    onTap: () {
                      setState(() {
                        if (personToMove == 1 && content[index].used == 0) {
                          content[index].color = Colors.green;
                          content[index].used = 1;
                          personToMove = 0;
                          countDraw++;
                        } else if (content[index].used == 0) {
                          content[index].color = Colors.red;
                          content[index].used = 1;
                          personToMove = 1;
                          countDraw++;
                        }

                        final PositionTicTacToe? outEnd = isEnd();
                        if (outEnd!.color != null) {
                          if (outEnd.color == Colors.green ||
                              outEnd.color == Colors.red) {
                            endGame = 1;
                            resetAtWon(outEnd);
                          } else if (outEnd.color == Colors.pink) {
                            whoWon = 'draw';
                            endGame = 1;
                          }
                        }
                      });
                    },
                  );
                }),
            if (endGame == 1)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      resetAtWon(PositionTicTacToe(
                          0, null, ValidationPoss(-1, -1, -1)));
                      endGame = 0;
                      personToMove = 1;
                      whoWon = null;
                      countDraw = 0;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Play Again!',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                ),
              )
          ],
        ));
  }
}

typedef OnTap = void Function();

class Item extends StatelessWidget {
  const Item({Key? key, required this.onTap, required this.backColor})
      : super(key: key);

  final Color? backColor;
  final OnTap onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
            border: Border.all(color: Colors.black),
            color: backColor),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
