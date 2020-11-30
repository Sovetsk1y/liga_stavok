// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_fun_facts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchFunFactsResponse _$MatchFunFactsResponseFromJson(
    Map<String, dynamic> json) {
  return MatchFunFactsResponse(
    json['sportEvent'] == null
        ? null
        : SportEvent.fromJson(json['sportEvent'] as Map<String, dynamic>),
    (json['facts'] as List)
        ?.map(
            (e) => e == null ? null : Fact.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MatchFunFactsResponseToJson(
        MatchFunFactsResponse instance) =>
    <String, dynamic>{
      'sportEvent': instance.sportEvent,
      'facts': instance.facts,
    };

Fact _$FactFromJson(Map<String, dynamic> json) {
  return Fact(
    json['statement'] as String,
  );
}

Map<String, dynamic> _$FactToJson(Fact instance) => <String, dynamic>{
      'statement': instance.statement,
    };
