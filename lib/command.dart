import 'package:flutter_ui_test/stack.dart';

abstract class Command {
  void execute();
  void undo(MyStack myStack);
}

class AddCommand implements Command {
  final MyStack _myStack;
  num _result = 0;

  AddCommand(this._myStack);

  @override
  void execute() {
    if(_myStack.check()){
      num num1 = _myStack.pop();
      num num2 = _myStack.pop();
      _result = num2 + num1;
      _myStack.operate( _result, num1);
    }
    else {
      print("Error"); // should implement on screen error display
    }
  }

  @override
  void undo(MyStack myStack) {
    num num1 = _myStack.pop();
    num num2 = _myStack.popOp();
    _result = num1 - num2;
    _myStack.undoOperate(_result, num2);
  }
}

class SubtractCommand implements Command {
  final MyStack _myStack;
  num _result = 0;

  SubtractCommand(this._myStack);

  @override
  void execute() {
    if(_myStack.check()) {
      num num1 = _myStack.pop();
      num num2 = _myStack.pop();
      _result = num2 - num1;
      _myStack.operate(_result, num1);
    }
    else {
      print("Error"); // should implement on screen error display
    }
  }

  @override
  void undo(MyStack myStack) {
    num num1 = _myStack.pop();
    num num2 = _myStack.popOp();
    _result = num1 + num2;
    _myStack.undoOperate(_result, num2);
  }
}

class MultiplyCommand implements Command {
  final MyStack _myStack;
  num _result = 0;

  MultiplyCommand(this._myStack);

  @override
  void execute() {
    if(_myStack.check()) {
      num num1 = _myStack.pop();
      num num2 = _myStack.pop();
      _result = num2 * num1;
      _myStack.operate(_result, num1);
    }
    else {
      print("Error"); // should implement on screen error display
    }
  }

  @override
  void undo(MyStack myStack) {
    num num1 = _myStack.pop();
    num num2 = _myStack.popOp();
    _result = num1 / num2;
    _myStack.undoOperate(_result, num2);
  }
}

class DivideCommand implements Command {
  final MyStack _myStack;
  num _result = 0;

  DivideCommand(this._myStack);

  @override
  void execute() {
    if(_myStack.check()) {
      num num1 = _myStack.pop();
      num num2 = _myStack.pop();
      _result = num2 / num1;
      _myStack.operate(_result, num1);
    }
    else {
      print("Error"); // should implement on screen error display
    }
  }

  @override
  void undo(MyStack myStack) {
    num num1 = _myStack.pop();
    num num2 = _myStack.popOp();
    _result = num1 * num2;
    _myStack.undoOperate(_result, num2);
  }
}

class ClearCommand implements Command {
  final MyStack _myStack;

  ClearCommand(this._myStack);

  @override
  void execute() {
    _myStack.clear();
  }

  @override
  void undo(MyStack myStack) {
      // clear is clear
  }
}

class UndoCommand implements Command {
  final MyStack _myStack;
  final Command _lastCommand;

  UndoCommand(this._myStack, this._lastCommand);

  @override
  void execute() {
    _lastCommand.undo(_myStack);
  }

  @override
  void undo(MyStack myStack) {
    // This should be called redo
  }
}

class EnterCommand implements Command {
  final MyStack _myStack;

  EnterCommand(this._myStack);

  @override
  void execute() {
    _myStack.push();
  }

  @override
  void undo(MyStack myStack) {
    _myStack.pop();
  }
}

class CurrentCommand implements Command {
  final MyStack _myStack;
  final num _number;

  CurrentCommand(this._myStack, this._number);

  @override
  void execute() {
    _myStack.display(_number);
  }

  @override
  void undo(MyStack myStack) {
    _myStack.cutDisplay();
  }
}