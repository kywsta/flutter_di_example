import 'package:flutter_di_example/provider/counter.dart';

class CounterTextTranslation {
  final Counter counter;

  CounterTextTranslation(this.counter);

  String get text => 'You have clicked ${counter.count} times';
}
