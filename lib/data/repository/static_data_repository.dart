import 'package:liga/data/model/match_fun_facts.dart';
import 'package:liga/data/model/team_results.dart';
import 'package:liga/net/network_client.dart';

import '../../config.dart';

class StaticDataRepository {
  static const int EMPTY_TOTAL_RESULT = -1;

  static const int _QUANTITY_LAST_MATCHES = 5;
  static const String _MATCH_STATUS_CLOSED = 'closed';
  static const String _QUALIFIER_HOME = 'home';
  static const String _QUALIFIER_AWAY = 'away';
  static const String _COMPETITOR_ID_PREFIX = 'sr:competitor:';

  final NetworkClient _networkClient;
  final Config _config;

  static StaticDataRepository _instance;

  factory StaticDataRepository(networkClient, config) {
    return _instance ?? StaticDataRepository._internal(networkClient, config);
  }

  StaticDataRepository._internal(this._networkClient, this._config) {
    _instance = this;
  }

  Future<List<MatchResult>> getLastMatchesResults(String competitorId) async {
    String apiKey = await _config.getApiKey();
    TeamResults teamResults = await _networkClient.getTeamResults(competitorId, apiKey);
    List<Result> lastFiveFinishedMatches = _getQuantityLastFinishedMatches(teamResults.results, _QUANTITY_LAST_MATCHES);
    return _mapResponseToMatchesResults(lastFiveFinishedMatches, _COMPETITOR_ID_PREFIX + competitorId);
  }

  Future<int> getIndividualTotalForLastMatches(String competitorId) async {
    String apiKey = await _config.getApiKey();
    TeamResults teamResults = await _networkClient.getTeamResults(competitorId, apiKey);
    List<Result> lastFiveFinishedMatches = _getQuantityLastFinishedMatches(teamResults.results, _QUANTITY_LAST_MATCHES);
    return _getIndividualTotalFor(lastFiveFinishedMatches, _COMPETITOR_ID_PREFIX + competitorId);
  }

  Future<List<String>> getMatchFunFacts(String matchId, int factsNumber) async {
    String apiKey = await _config.getApiKey();
    MatchFunFactsResponse funFactsResponse = await _networkClient.getFunFacts(matchId, apiKey);
    return _getMatchFunFacts(factsNumber, funFactsResponse.facts);
  }

  List<String> _getMatchFunFacts(int factsNumber, List<Fact> facts) {
    List<String> result = List<String>();
    if (facts == null || facts.isEmpty) {
      return result;
    } else if (factsNumber > facts.length) {
      for (final fact in facts) {
        String factStatement = fact.statement;
        if (_factStatementNotEmpty(factStatement)) {
          result.add(factStatement);
        }
      }
    } else {
      for (int i = 0; i < factsNumber; i++) {
        String factStatement = facts[i].statement;
        if (_factStatementNotEmpty(factStatement)) {
          result.add(factStatement);
        }
      }
    }
    return result;
  }

  bool _factStatementNotEmpty(String factStatement) => factStatement != null && factStatement.isNotEmpty;

  List<MatchResult> _mapResponseToMatchesResults(List<Result> results, String competitorId) {
    List<MatchResult> matchesResults = List<MatchResult>();
    for (final result in results) {
      String winnerId = result.sportEventStatus.winnerId;
      if (winnerId == null || winnerId.isEmpty) {
        matchesResults.add(MatchResult.draw);
      } else if (winnerId == competitorId) {
        matchesResults.add(MatchResult.win);
      } else {
        matchesResults.add(MatchResult.lose);
      }
    }
    return matchesResults;
  }

  List<Result> _getQuantityLastFinishedMatches(List<Result> results, int quantity) {
    List<Result> lastFiveFinishedMatches = List<Result>();
    for (final result in results) {
      if (lastFiveFinishedMatches.length < quantity) {
        if (_MATCH_STATUS_CLOSED == result.sportEventStatus.status) {
          lastFiveFinishedMatches.add(result);
        }
      } else {
        break;
      }
    }
    return lastFiveFinishedMatches;
  }

  int _getIndividualTotalFor(List<Result> matches, String competitorId) {
    int total;
    if (matches.isEmpty) {
      total = EMPTY_TOTAL_RESULT;
    } else {
      total = 0;
    }
    for (final match in matches) {
      _Qualifier qualifier;
      for (final competitor in match.sportEvent.competitors) {
        if (competitor.id == competitorId) {
          if (_QUALIFIER_HOME == competitor.qualifier) {
            qualifier = _Qualifier.home;
          } else if (_QUALIFIER_AWAY == competitor.qualifier) {
            qualifier = _Qualifier.away;
          } else {
            qualifier = _Qualifier.unknown;
          }
          break;
        }
      }
      if (qualifier == _Qualifier.home) {
        total += match.sportEventStatus.homeScore;
      } else if (qualifier == _Qualifier.away) {
        total += match.sportEventStatus.awayScore;
      }
    }

    return total;
  }
}

enum _Qualifier { home, away, unknown }
