// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'convert_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConvertUiState {

  String get amountText;

  Currency get fromCurrency;

  Currency get toCurrency;

  String get rateText;

  String get resultText;

  /// Create a copy of ConvertUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConvertUiStateCopyWith<ConvertUiState> get copyWith =>
      _$ConvertUiStateCopyWithImpl<ConvertUiState>(this as ConvertUiState, _$identity);


}

/// @nodoc
abstract mixin class $ConvertUiStateCopyWith<$Res> {
  factory $ConvertUiStateCopyWith(ConvertUiState value,
      $Res Function(ConvertUiState) _then) = _$ConvertUiStateCopyWithImpl;

  @useResult
  $Res call({
    String amountText, Currency fromCurrency, Currency toCurrency, String rateText, String resultText
  });


}

/// @nodoc
class _$ConvertUiStateCopyWithImpl<$Res>
    implements $ConvertUiStateCopyWith<$Res> {
  _$ConvertUiStateCopyWithImpl(this._self, this._then);

  final ConvertUiState _self;
  final $Res Function(ConvertUiState) _then;

  /// Create a copy of ConvertUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? amountText = null, Object? fromCurrency = null, Object? toCurrency = null, Object? rateText = null, Object? resultText = null,}) {
    return _then(_self.copyWith(
      amountText: null == amountText ? _self.amountText : amountText // ignore: cast_nullable_to_non_nullable
      as String,
      fromCurrency: null == fromCurrency ? _self.fromCurrency : fromCurrency // ignore: cast_nullable_to_non_nullable
      as Currency,
      toCurrency: null == toCurrency ? _self.toCurrency : toCurrency // ignore: cast_nullable_to_non_nullable
      as Currency,
      rateText: null == rateText ? _self.rateText : rateText // ignore: cast_nullable_to_non_nullable
      as String,
      resultText: null == resultText ? _self.resultText : resultText // ignore: cast_nullable_to_non_nullable
      as String,
    ));
  }

}


/// Adds pattern-matching-related methods to [ConvertUiState].
extension ConvertUiStatePatterns on ConvertUiState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  TResult Function( _ConvertUiState value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _ConvertUiState() when $default != null:
  return $default(_that);case _:
  return orElse();

  }
  }
  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConvertUiState value) $default,){
  final _that = this;
  switch (_that) {
  case _ConvertUiState():
  return $default(_that);case _:
  throw StateError('Unexpected subclass');

  }
  }
  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConvertUiState value)? $default,){
  final _that = this;
  switch (_that) {
  case _ConvertUiState() when $default != null:
  return $default(_that);case _:
  return null;

  }
  }
  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String amountText, Currency fromCurrency, Currency toCurrency, String rateText, String resultText)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _ConvertUiState() when $default != null:
  return $default(_that.amountText,_that.fromCurrency,_that.toCurrency,_that.rateText,_that.resultText);case _:
  return orElse();

  }
  }
  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String amountText, Currency fromCurrency, Currency toCurrency, String rateText, String resultText) $default,) {final _that = this;
  switch (_that) {
  case _ConvertUiState():
  return $default(_that.amountText,_that.fromCurrency,_that.toCurrency,_that.rateText,_that.resultText);case _:
  throw StateError('Unexpected subclass');

  }
  }
  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String amountText, Currency fromCurrency, Currency toCurrency, String rateText, String resultText)? $default,) {final _that = this;
  switch (_that) {
  case _ConvertUiState() when $default != null:
  return $default(_that.amountText,_that.fromCurrency,_that.toCurrency,_that.rateText,_that.resultText);case _:
  return null;

  }
  }

}

/// @nodoc


class _ConvertUiState extends ConvertUiState {
  const _ConvertUiState(
      {required this.amountText, required this.fromCurrency, required this.toCurrency, required this.rateText, required this.resultText})
      : super._();


  @override final String amountText;
  @override final Currency fromCurrency;
  @override final Currency toCurrency;
  @override final String rateText;
  @override final String resultText;

  /// Create a copy of ConvertUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConvertUiStateCopyWith<_ConvertUiState> get copyWith =>
      __$ConvertUiStateCopyWithImpl<_ConvertUiState>(this, _$identity);


}

/// @nodoc
abstract mixin class _$ConvertUiStateCopyWith<$Res> implements $ConvertUiStateCopyWith<$Res> {
  factory _$ConvertUiStateCopyWith(_ConvertUiState value,
      $Res Function(_ConvertUiState) _then) = __$ConvertUiStateCopyWithImpl;

  @override
  @useResult
  $Res call({
    String amountText, Currency fromCurrency, Currency toCurrency, String rateText, String resultText
  });


}

/// @nodoc
class __$ConvertUiStateCopyWithImpl<$Res>
    implements _$ConvertUiStateCopyWith<$Res> {
  __$ConvertUiStateCopyWithImpl(this._self, this._then);

  final _ConvertUiState _self;
  final $Res Function(_ConvertUiState) _then;

  /// Create a copy of ConvertUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? amountText = null, Object? fromCurrency = null, Object? toCurrency = null, Object? rateText = null, Object? resultText = null,}) {
    return _then(_ConvertUiState(
      amountText: null == amountText ? _self.amountText : amountText // ignore: cast_nullable_to_non_nullable
      as String,
      fromCurrency: null == fromCurrency ? _self.fromCurrency : fromCurrency // ignore: cast_nullable_to_non_nullable
      as Currency,
      toCurrency: null == toCurrency ? _self.toCurrency : toCurrency // ignore: cast_nullable_to_non_nullable
      as Currency,
      rateText: null == rateText ? _self.rateText : rateText // ignore: cast_nullable_to_non_nullable
      as String,
      resultText: null == resultText ? _self.resultText : resultText // ignore: cast_nullable_to_non_nullable
      as String,
    ));
  }


}

// dart format on
