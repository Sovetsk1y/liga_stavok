import 'package:bloc/bloc.dart';
import 'package:liga/data/model/crypto_currency.dart';
import 'package:liga/data/repository/crypto_currency_repository.dart';
import 'package:liga/feature/currencies/currencies_event.dart';
import 'package:liga/feature/currencies/currencies_state.dart';
import 'package:liga/utils/log.dart';

class CurrenciesBloc extends Bloc<CurrenciesEvent, CurrenciesState> {
  final CryptoCurrencyRepository _repository;
  final Log _log;

  CurrenciesBloc(this._repository, this._log) : super(Initial());

  @override
  Stream<CurrenciesState> mapEventToState(CurrenciesEvent event) async* {
    _log.d('Receive currencies event - $event');
    if (event is Initial) {
      yield Loading();

      try {
        final List<CryptoCurrency> cryptoCurrencies = await _repository.getCryptoCurrencies();
        yield Success(cryptoCurrencies);
      } catch (exception) {}
    }
  }
}
