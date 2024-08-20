import 'package:json_annotation/json_annotation.dart';

part 'latest_currency.g.dart';

@JsonSerializable()
class LatestCurrency {
  final Meta meta;
  final Map<String, CurrencyRaw> data;

  LatestCurrency({
    required this.meta,
    required this.data,
  });

  factory LatestCurrency.fromJson(Map<String, dynamic> json) => _$LatestCurrencyFromJson(json);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "last_updated_at")
  final String lastUpdatedAt;

  Meta({
    required this.lastUpdatedAt,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@JsonSerializable()
class CurrencyRaw {
  final String code;
  final double value;

  CurrencyRaw({
    required this.code,
    required this.value,
  });

  factory CurrencyRaw.fromJson(Map<String, dynamic> json) => _$CurrencyRawFromJson(json);
}