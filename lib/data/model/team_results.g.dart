// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamResults _$TeamResultsFromJson(Map<String, dynamic> json) {
  return TeamResults(
    json['team'] == null
        ? null
        : Team.fromJson(json['team'] as Map<String, dynamic>),
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Result.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TeamResultsToJson(TeamResults instance) =>
    <String, dynamic>{
      'team': instance.team,
      'results': instance.results,
    };

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
    json['id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['sport_event'] == null
        ? null
        : SportEvent.fromJson(json['sport_event'] as Map<String, dynamic>),
    json['sport_event_status'] == null
        ? null
        : SportEventStatus.fromJson(
            json['sport_event_status'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'sport_event': instance.sportEvent,
      'sport_event_status': instance.sportEventStatus,
    };

SportEvent _$SportEventFromJson(Map<String, dynamic> json) {
  return SportEvent(
    (json['competitors'] as List)
        ?.map((e) =>
            e == null ? null : Competitor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SportEventToJson(SportEvent instance) =>
    <String, dynamic>{
      'competitors': instance.competitors,
    };

Competitor _$CompetitorFromJson(Map<String, dynamic> json) {
  return Competitor(
    json['id'] as String,
    json['name'] as String,
    json['country'] as String,
    json['qualifier'] as String,
  );
}

Map<String, dynamic> _$CompetitorToJson(Competitor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'qualifier': instance.qualifier,
    };

SportEventStatus _$SportEventStatusFromJson(Map<String, dynamic> json) {
  return SportEventStatus(
    json['status'] as String,
    json['home_score'] as int,
    json['away_score'] as int,
    json['winner_id'] as String,
  );
}

Map<String, dynamic> _$SportEventStatusToJson(SportEventStatus instance) =>
    <String, dynamic>{
      'status': instance.status,
      'home_score': instance.homeScore,
      'away_score': instance.awayScore,
      'winner_id': instance.winnerId,
    };
