// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestCurrency _$LatestCurrencyFromJson(Map<String, dynamic> json) => LatestCurrency(
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
  data: (json['data'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, CurrencyRaw.fromJson(e as Map<String, dynamic>)),
  ),
);

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(lastUpdatedAt: json['last_updated_at'] as String);

CurrencyRaw _$CurrencyRawFromJson(Map<String, dynamic> json) =>
    CurrencyRaw(code: json['code'] as String, value: (json['value'] as num).toDouble());
