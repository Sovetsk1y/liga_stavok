import 'package:equatable/equatable.dart';

abstract class SportWidgetState extends Equatable {
  const SportWidgetState();

  @override
  List<Object> get props => [];
}

class Initial extends SportWidgetState {
  @override
  String toString() => 'Initial sport widget state';
}

class Loading extends SportWidgetState {
  @override
  String toString() => 'Loading sport widget state';
}

class Success extends SportWidgetState {
  /*final List<CryptoCurrency> cryptoCurrencies;

  Success(this.cryptoCurrencies);

  @override
  List<Object> get props => [cryptoCurrencies];*/

  @override
  String toString() => 'Success sport widget state';
}

class Failure extends SportWidgetState {
  @override
  String toString() => 'Failure sport widget state';
}

enum Type { serverNotAvailable, noInternetConnection, unknown }
