import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator by Nicolle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator by Nicolle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String expression = '';
  String result = '';

  void _handleButtonPress(String input) {
    setState(() {
      if (input == '=') {
        try {
          final expressionParsed = Expression.parse(expression);
          final evaluator = ExpressionEvaluator();
          final resultValue = evaluator.eval(expressionParsed, {});
          if (expression.contains('/0')) {
            result = 'Error';
          } else {
            result = resultValue.toString();
          }
        } catch (e) {
          result = 'Error';
        }
      } else if (input == 'C') {
        expression = '';
        result = '';
      } else {
        expression += input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              expression,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 10),
            Text(
              result,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildButton('C'), 
              ],
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 1.5,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
                _buildButton('0', flex: 2),
                _buildButton('.'),
                _buildButton('+'),
                _buildButton('='),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        onPressed: () => _handleButtonPress(label),
        child: Text(label, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
