// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NetworkClient implements NetworkClient {
  _NetworkClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.sportradar.us';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<TeamResults> getTeamResults(competitorId, apiKey) async {
    ArgumentError.checkNotNull(competitorId, 'competitorId');
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'api_key': apiKey};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/soccer-t3/intl/en/teams/sr:competitor:$competitorId/results.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TeamResults.fromJson(_result.data);
    return value;
  }
}
