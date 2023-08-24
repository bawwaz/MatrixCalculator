import 'package:flutter/material.dart';

void main() {
  runApp(MatrixCalculatorApp());
}

class MatrixCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrix Calculator',
      theme: ThemeData(
        primarySwatch:
            createCustomMaterialColor(Color.fromARGB(255, 30, 36, 40)),
      ),
      home: MatrixCalculatorScreen(),
    );
  }

  MaterialColor createCustomMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}

class MatrixCalculatorScreen extends StatefulWidget {
  @override
  _MatrixCalculatorScreenState createState() => _MatrixCalculatorScreenState();
}

class _MatrixCalculatorScreenState extends State<MatrixCalculatorScreen> {
  List<List<double>> matrix1 =
      List.generate(3, (i) => List.generate(3, (j) => 0.0));
  List<List<double>> matrix2 =
      List.generate(3, (i) => List.generate(3, (j) => 0.0));
  List<List<double>> resultMatrix =
      List.generate(3, (i) => List.generate(3, (j) => 0.0));

  void calculate(Operation operation) {
    setState(() {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (operation == Operation.Add) {
            resultMatrix[i][j] = matrix1[i][j] + matrix2[i][j];
          } else if (operation == Operation.Subtract) {
            resultMatrix[i][j] = matrix1[i][j] - matrix2[i][j];
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrix Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Matrix 1',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (int i = 0; i < 3; i++)
                Row(
                  children: [
                    for (int j = 0; j < 3; j++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              matrix1[i][j] = double.tryParse(value) ?? 0.0;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              SizedBox(height: 16),
              Text(
                'Matrix 2',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (int i = 0; i < 3; i++)
                Row(
                  children: [
                    for (int j = 0; j < 3; j++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              matrix2[i][j] = double.tryParse(value) ?? 0.0;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => calculate(Operation.Add),
                    child: Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () => calculate(Operation.Subtract),
                    child: Text('Subtract'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Result Matrix:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              for (int i = 0; i < 3; i++) Text(resultMatrix[i].toString()),
            ],
          ),
        ),
      ),
    );
  }
}

enum Operation {
  Add,
  Subtract,
}
