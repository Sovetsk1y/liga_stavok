import 'package:dio/dio.dart';
import 'package:liga/config.dart';
import 'package:liga/net/exceptions.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  static const String _AUTH_HEADER = 'X-CMC_PRO_API_KEY';

  Config _config;

  HeaderInterceptor(this._config);

  @override
  Future onRequest(RequestOptions options) {
    options.headers.putIfAbsent(_AUTH_HEADER, () async => await _config.getApiKey());
    return super.onRequest(options);
  }
}

class ErrorHandlerInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err) async {
    if (err.type == DioErrorType.CONNECT_TIMEOUT) {
      throw NetworkNotAvailableException();
    } else if (err.type == DioErrorType.RECEIVE_TIMEOUT || err.type == DioErrorType.RESPONSE) {
      throw ServerNotAvailableException();
    } else {
      return super.onError(err);
    }
  }
}
