import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DayCalculator(),
    );
  }
}

class DayCalculator extends StatefulWidget {
  @override
  _DayCalculatorState createState() => _DayCalculatorState();
}

class _DayCalculatorState extends State<DayCalculator> {
  int day = 1;
  int month = 1;
  int year = 2022;

  List<int> f = [0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5];

  String resultText = '';

  String getDayOfWeek() {
    int centuryDigits = (year / 100).floor();
    int yearDigits = year % 100;

    int result = (day +
        f[(month - 1)] +
        yearDigits +
        (yearDigits / 4).floor() +
        (centuryDigits / 4).floor() -
        2 * centuryDigits) %
        7;

    List<String> daysOfWeek = [
      "Saturday",
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday"
    ];
    return daysOfWeek[(result + 7) % 7];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Day', style: TextStyle(fontSize: 14)),
                      NumberPicker(
                        value: day,
                        minValue: 1,
                        maxValue: 31,
                        onChanged: (value) => setState(() => day = value),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Month', style: TextStyle(fontSize: 14)),
                      NumberPicker(
                        value: month,
                        minValue: 1,
                        maxValue: 12,
                        onChanged: (value) => setState(() => month = value),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Year', style: TextStyle(fontSize: 14)),
                      NumberPicker(
                        value: year,
                        minValue: 1900,
                        maxValue: 2100,
                        onChanged: (value) => setState(() => year = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  resultText = 'you was born in : ${getDayOfWeek()}';
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Calculate',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  resultText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
