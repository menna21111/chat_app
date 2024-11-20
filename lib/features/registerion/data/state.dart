class State {
  const State();
}

class Initial extends State {}

class Changestate extends State {
  dynamic s;

  Changestate({this.s});
}
