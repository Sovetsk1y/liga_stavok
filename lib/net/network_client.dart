import 'package:dio/dio.dart';
import 'package:liga/data/model/crypto_currency.dart';
import 'package:retrofit/http.dart';

part 'network_client.g.dart';

@RestApi(baseUrl: "https://pro-api.coinmarketcap.com")
abstract class NetworkClient {
  factory NetworkClient(Dio dio, {String baseUrl}) = _NetworkClient;

  @GET("/v1/cryptocurrency/map")
  Future<List<CryptoCurrency>> getCurrencies();
}
