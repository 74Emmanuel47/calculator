import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userQuestion = "";
  String userAnswer = "";
  double fontSizerA = 20;

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "X",
    "6",
    "5",
    "4",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: fontSizerA,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  if (buttons[index] == 'C') {
                    return MyButton(
                      onTap: () {
                        setState(() {
                          userAnswer = "";
                          userQuestion = "";
                        });
                      },
                      color: Colors.amber.shade200,
                      buttonText: buttons[index],
                      textColor: Colors.black,
                    );
                  } else if (buttons[index] == 'DEL') {
                    return MyButton(
                      onTap: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      color: Colors.amber.shade200,
                      buttonText: buttons[index],
                      textColor: Colors.black,
                    );
                  } else if (buttons[index] == 'ANS') {
                    return MyButton(
                      onTap: () {
                        if (userAnswer != "") {
                          setState(() {
                            userQuestion = userAnswer;
                          });
                        }
                      },
                      color: Colors.amber.shade200,
                      buttonText: buttons[index],
                      textColor: Colors.black,
                    );
                  } else if (buttons[index] == '=') {
                    return MyButton(
                      onTap: () => finishArith(),
                      color: Colors.amber,
                      buttonText: buttons[index],
                      textColor: Colors.white,
                    );
                  } else {
                    return MyButton(
                      onTap: () {
                        startArith();
                        setState(() {
                          userQuestion += buttons[index];
                        });
                        performArith();
                      },
                      color: isOperator(buttons[index])
                          ? Colors.amber
                          : Colors.white,
                      buttonText: buttons[index],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.amber,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'X' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  performArith() {
    Parser parser = Parser();
    Expression exp = parser.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      userAnswer = eval.toString();
    });
  }

  startArith() {
    setState(() {
      fontSizerA = 20;
    });
  }

  finishArith() {
    setState(() {
      fontSizerA = 30;
    });
  }
}
