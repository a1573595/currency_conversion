import 'package:currency_conversion/src/data/model/latest_currency.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Currency with EquatableMixin {
  @Id()
  int id;
  final String code;
  final String flagImage;
  final double twdPrice;

  Currency({
    this.id = 0,
    required this.code,
    required this.flagImage,
    required this.twdPrice,
  });

  factory Currency.fromRaw(CurrencyRaw raw) => Currency(
        code: raw.code,
        flagImage: "https://flagsapi.com/${raw.code[0]}${raw.code[1]}/flat/32.png",
        twdPrice: raw.value,
      );

  @override
  List<Object?> get props => [
        code,
        flagImage,
        twdPrice,
      ];
}
