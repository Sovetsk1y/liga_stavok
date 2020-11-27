import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_currency.g.dart';

@JsonSerializable()
class CryptoCurrency extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final String slug;

  @JsonKey(name: 'is_active')
  final int isActive;

  @JsonKey(name: 'first_historical_data')
  final String firstHistoricalData;

  @JsonKey(name: 'last_historical_data')
  final String lastHistoricalData;

  CryptoCurrency(this.id, this.name, this.symbol, this.slug, this.isActive, this.firstHistoricalData, this.lastHistoricalData);

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) => _$CryptoCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCurrencyToJson(this);

  @override
  List<Object> get props => [id, name, symbol, slug, isActive, firstHistoricalData, lastHistoricalData];
}
