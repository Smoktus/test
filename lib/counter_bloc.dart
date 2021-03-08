import 'dart:async';

import 'package:bloc_text/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream; // output the int

  //Entrée de l'interface
  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink =>
      _counterEventController.sink; // input get input from UI

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
