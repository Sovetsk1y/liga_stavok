import 'package:equatable/equatable.dart';
import 'package:liga/data/model/crypto_currency.dart';

abstract class CurrenciesState extends Equatable {
  const CurrenciesState();

  @override
  List<Object> get props => [];
}

class Initial extends CurrenciesState {
  @override
  String toString() => 'Initial currencies state';
}

class Loading extends CurrenciesState {
  @override
  String toString() => 'Loading currencies state';
}

class Success extends CurrenciesState {
  final List<CryptoCurrency> cryptoCurrencies;

  Success(this.cryptoCurrencies);

  @override
  List<Object> get props => [cryptoCurrencies];

  @override
  String toString() => 'Success currencies state';
}

class Failure extends CurrenciesState {
  @override
  String toString() => 'Failure currencies state';
}

enum Type { serverNotAvailable, noInternetConnection, unknown }
