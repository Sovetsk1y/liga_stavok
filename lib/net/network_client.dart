import 'package:dio/dio.dart';
import 'package:liga/data/model/live_results.dart';
import 'package:liga/data/model/match_fun_facts.dart';
import 'package:liga/data/model/match_timeline.dart';
import 'package:liga/data/model/team_results.dart';
import 'package:retrofit/http.dart';

part 'network_client.g.dart';

@RestApi(baseUrl: 'https://api.sportradar.us')
abstract class NetworkClient {
  factory NetworkClient(Dio dio, {String baseUrl}) = _NetworkClient;

  @GET('/soccer-t3/intl/en/teams/{competitorId}/results.json')
  Future<TeamResultsResponse> getTeamResults(@Path() String competitorId, @Query('api_key') String apiKey);

  @GET('/soccer-t3/intl/en/matches/{matchId}/funfacts.json')
  Future<MatchFunFactsResponse> getFunFacts(@Path() String matchId, @Query('api_key') String apiKey);

  @GET('/soccer-t3/intl/en/schedules/live/results.json')
  Future<LiveResultsResponse> getLiveResults(@Query('api_key') String apiKey);

  @GET('/soccer-t3/intl/en/matches/{matchId}/timeline.json')
  Future<MatchTimelineResponse> getMatchTimeLine(@Path() String matchId, @Query('api_key') String apiKey);
}
