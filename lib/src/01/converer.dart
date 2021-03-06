import 'package:flutter/material.dart';

void main() {
  runApp(const Converter());
}

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String? _amountUSD;
  String? _amountLEI = '';

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Currency Convertor'),
        ),
        body: Container(
          color: Colors.red,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                      'https://1.bp.blogspot.com/-kDEsmpQSxIY/VC6lD5YuHyI/AAAAAAAAJ6k/BgZzmegj_sw/s1600/Dollars-009.jpg'),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (String? _amountUSD) {
                          if (_amountUSD == null || !isNumeric(_amountUSD)) {
                            return 'Please enter some valid number';
                          } else {
                            return null;
                          }
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Enter the amount in USD',
                          suffix: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              setState(() {
                                _amountUSD = null;
                              });
                            },
                          ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            if (value.isEmpty) {
                              _amountUSD = null;
                            } else {
                              _amountUSD = value;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            _amountLEI = (double.parse(_amountUSD.toString()) * 4.06).toStringAsFixed(2) + ' LEI';
                          } else {
                            _amountLEI = '';
                          }
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'CONVERT!',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                    ),
                  ),
                  Text(
                    _amountLEI.toString(),
                    style: const TextStyle(color: Colors.black54, fontSize: 29.0, fontWeight: FontWeight.bold),
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
