import 'package:dio/dio.dart';
import 'package:liga/data/model/team_results.dart';
import 'package:retrofit/http.dart';

part 'network_client.g.dart';

@RestApi(baseUrl: "https://api.sportradar.us")
abstract class NetworkClient {
  factory NetworkClient(Dio dio, {String baseUrl}) = _NetworkClient;

  @GET("/soccer-t3/intl/en/teams/sr:competitor:{competitorId}/results.json")
  Future<TeamResults> getTeamResults(@Path() String competitorId, @Query("api_key") String apiKey);
}
