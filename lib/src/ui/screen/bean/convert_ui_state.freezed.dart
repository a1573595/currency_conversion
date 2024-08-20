// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'convert_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConvertUiState {
  String get amountText => throw _privateConstructorUsedError;
  Currency get fromCurrency => throw _privateConstructorUsedError;
  Currency get toCurrency => throw _privateConstructorUsedError;
  String get rateText => throw _privateConstructorUsedError;
  String get resultText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConvertUiStateCopyWith<ConvertUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConvertUiStateCopyWith<$Res> {
  factory $ConvertUiStateCopyWith(
          ConvertUiState value, $Res Function(ConvertUiState) then) =
      _$ConvertUiStateCopyWithImpl<$Res, ConvertUiState>;
  @useResult
  $Res call(
      {String amountText,
      Currency fromCurrency,
      Currency toCurrency,
      String rateText,
      String resultText});
}

/// @nodoc
class _$ConvertUiStateCopyWithImpl<$Res, $Val extends ConvertUiState>
    implements $ConvertUiStateCopyWith<$Res> {
  _$ConvertUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amountText = null,
    Object? fromCurrency = null,
    Object? toCurrency = null,
    Object? rateText = null,
    Object? resultText = null,
  }) {
    return _then(_value.copyWith(
      amountText: null == amountText
          ? _value.amountText
          : amountText // ignore: cast_nullable_to_non_nullable
              as String,
      fromCurrency: null == fromCurrency
          ? _value.fromCurrency
          : fromCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      toCurrency: null == toCurrency
          ? _value.toCurrency
          : toCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      rateText: null == rateText
          ? _value.rateText
          : rateText // ignore: cast_nullable_to_non_nullable
              as String,
      resultText: null == resultText
          ? _value.resultText
          : resultText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConvertUiStateImplCopyWith<$Res>
    implements $ConvertUiStateCopyWith<$Res> {
  factory _$$ConvertUiStateImplCopyWith(_$ConvertUiStateImpl value,
          $Res Function(_$ConvertUiStateImpl) then) =
      __$$ConvertUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String amountText,
      Currency fromCurrency,
      Currency toCurrency,
      String rateText,
      String resultText});
}

/// @nodoc
class __$$ConvertUiStateImplCopyWithImpl<$Res>
    extends _$ConvertUiStateCopyWithImpl<$Res, _$ConvertUiStateImpl>
    implements _$$ConvertUiStateImplCopyWith<$Res> {
  __$$ConvertUiStateImplCopyWithImpl(
      _$ConvertUiStateImpl _value, $Res Function(_$ConvertUiStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amountText = null,
    Object? fromCurrency = null,
    Object? toCurrency = null,
    Object? rateText = null,
    Object? resultText = null,
  }) {
    return _then(_$ConvertUiStateImpl(
      amountText: null == amountText
          ? _value.amountText
          : amountText // ignore: cast_nullable_to_non_nullable
              as String,
      fromCurrency: null == fromCurrency
          ? _value.fromCurrency
          : fromCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      toCurrency: null == toCurrency
          ? _value.toCurrency
          : toCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      rateText: null == rateText
          ? _value.rateText
          : rateText // ignore: cast_nullable_to_non_nullable
              as String,
      resultText: null == resultText
          ? _value.resultText
          : resultText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConvertUiStateImpl extends _ConvertUiState {
  const _$ConvertUiStateImpl(
      {required this.amountText,
      required this.fromCurrency,
      required this.toCurrency,
      required this.rateText,
      required this.resultText})
      : super._();

  @override
  final String amountText;
  @override
  final Currency fromCurrency;
  @override
  final Currency toCurrency;
  @override
  final String rateText;
  @override
  final String resultText;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConvertUiStateImplCopyWith<_$ConvertUiStateImpl> get copyWith =>
      __$$ConvertUiStateImplCopyWithImpl<_$ConvertUiStateImpl>(
          this, _$identity);
}

abstract class _ConvertUiState extends ConvertUiState {
  const factory _ConvertUiState(
      {required final String amountText,
      required final Currency fromCurrency,
      required final Currency toCurrency,
      required final String rateText,
      required final String resultText}) = _$ConvertUiStateImpl;
  const _ConvertUiState._() : super._();

  @override
  String get amountText;
  @override
  Currency get fromCurrency;
  @override
  Currency get toCurrency;
  @override
  String get rateText;
  @override
  String get resultText;
  @override
  @JsonKey(ignore: true)
  _$$ConvertUiStateImplCopyWith<_$ConvertUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
