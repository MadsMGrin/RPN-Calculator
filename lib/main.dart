import 'package:flutter/material.dart';
import 'package:flutter_ui_test/stack.dart';

import 'command.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPN Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'RPN Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyStack _myStack = MyStack();
  List<Command> _commands = [];
  String output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      Command? command = null;
      switch (buttonText) {
        case "+":
          command = AddCommand(_myStack);
          break;
        case "-":
          command = SubtractCommand(_myStack);
          break;
        case "*":
          command = MultiplyCommand(_myStack);
          break;
        case "/":
          command = DivideCommand(_myStack);
          break;
        case "Clear":
          command = ClearCommand(_myStack);
          break;
        case "undo":
          if (_commands.isNotEmpty) {
            Command lastCommand = _commands.removeLast();
            command = UndoCommand(_myStack, lastCommand);
          }
          break;
        case "Enter":
          command = EnterCommand(_myStack);
          break;
        default:
          int? number = int.tryParse(buttonText);
          if (number != null) {
            command = CurrentCommand(_myStack, number);
          }
      }

      if (command != null) {
        command.execute();
        if(command is! UndoCommand) { // undo should not be added to the command stack
          _commands.add(command);
        }
      }

      if (_myStack.isEmpty()) {
        output = "0";
      } else {
        output = _myStack.peek().toString();
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: SizedBox(
        height: 70.0,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: OutlinedButton(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => buttonPressed(buttonText),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: _myStack.emptyCurrent?
              const Text(
                "0",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 48.0),
              ):
              Text(
                textAlign: TextAlign.center,
                _myStack.current.toString(),
                style: TextStyle(fontSize: 48.0),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child:
              Text(
                _myStack.stack.toString(),
                style: TextStyle(fontSize: 28.0),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child:
              Text(
                _myStack.operatorStack.toString(),
                style: TextStyle(fontSize: 28.0),
              ),
            ),
            const Expanded(
              child: Divider(),
            ),

            Column(children: [
              Row(
                children: [
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('/'),
                ],
              ),
              Row(
                children: [
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('*'),
                ],
              ),
              Row(
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('-'),
                ],
              ),
              Row(
                children: [
                  buildButton(','),
                  buildButton('0'),
                  buildButton('Clear'),
                  buildButton('+'),
                ],
              ),
              Row(
                children: [buildButton("Enter"), buildButton("undo")],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}