class MyStack {
  static final MyStack _singleton = MyStack._internal();
  final List<num> _stack = [];
  final List<dynamic> _operatorStack = [];
  String _current = "";
  bool _emptyCurrent = true;

  List<num> get stack => _stack;


  factory MyStack() { // Making the stack singleton allows us to share the instance in the command pattern
    return _singleton;
  }

  MyStack._internal();

  void push() {
    num? value = num.tryParse(_current);
    if(value != null) {
      _stack.add(value);
    }
    _current = "";
    _emptyCurrent = true;
  }

  void operate(num num1, num holdNum){
    _stack.add(num1);
    _operatorStack.add(holdNum);
  }

  void undoOperate(num num1, num2){
    _stack.add(num1);
    _stack.add(num2);
  }

  num pop() {
    return _stack.removeLast();
  }

  num popOp(){
    return _operatorStack.removeLast();
  }

  num peek() {
    return _stack.last;
  }

  num size() {
    return _stack.length;
  }

  bool isEmpty() {
    return _stack.isEmpty;
  }

  void clear() {
    _stack.clear();
    _operatorStack.clear();
    _current = "";
  }

  void display(num s){
    _current = _current + s.toString();
    _emptyCurrent = false;
  }

  void cutDisplay(){
    _current = _current.substring(0, _current.length - 1);
    if(_current == ""){
      _emptyCurrent = true;
    }
    print(_current);

  }

  bool check(){
    if(_stack.length >= 2){
      return true;
    }
    else {
      return false;
    }
  }

  List<dynamic> get operatorStack => _operatorStack;

  String get current => _current;

  bool get emptyCurrent => _emptyCurrent;
}