import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String result = '';

  void sum() {
    double num1 = double.tryParse(num1Controller.text) ?? 0.0;
    double num2 = double.tryParse(num2Controller.text) ?? 0.0;
    double sum = num1 + num2;
    setState(() {
      result = sum.toString();
    });
  }

  void rest() {
    double num1 = double.tryParse(num1Controller.text) ?? 0.0;
    double num2 = double.tryParse(num2Controller.text) ?? 0.0;
    double difference = num1 - num2;
    setState(() {
      result = difference.toString();
    });
  }

  void mult() {
    double num1 = double.tryParse(num1Controller.text) ?? 0.0;
    double num2 = double.tryParse(num2Controller.text) ?? 0.0;
    double product = num1 * num2;
    setState(() {
      result = product.toString();
    });
  }

  void divi() {
    double num1 = double.tryParse(num1Controller.text) ?? 0.0;
    double num2 = double.tryParse(num2Controller.text) ?? 0.0;
    if (num2 != 0) {
      double quotient = num1 / num2;
      setState(() {
        result = quotient.toString();
      });
    } else {
      setState(() {
        result = 'Infinity';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BottomAppBar(
              child: Container(
                height: 10.0,
                child: Center(
                  child: Text(
                    'Calculadora básica',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: num1Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: num2Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: sum,
                  child: Text('Sumar'),
                ),
                ElevatedButton(
                  onPressed: rest,
                  child: Text('Restar'),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: mult,
                  child: Text('Multiplicar'),
                ),
                ElevatedButton(
                  onPressed: divi,
                  child: Text('Dividir'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              ' $result',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
