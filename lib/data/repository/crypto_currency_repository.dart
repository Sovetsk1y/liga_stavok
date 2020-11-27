import 'package:liga/data/model/crypto_currency.dart';
import 'package:liga/net/network_client.dart';

class CryptoCurrencyRepository {
  final NetworkClient _networkClient;

  CryptoCurrencyRepository(this._networkClient);

  Future<List<CryptoCurrency>> getCryptoCurrencies() async {
    return _networkClient.getCurrencies();
  }
}
