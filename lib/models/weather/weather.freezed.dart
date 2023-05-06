// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return _Weather.fromJson(json);
}

/// @nodoc
mixin _$Weather {
  double get humidity => throw _privateConstructorUsedError;
  double get temp => throw _privateConstructorUsedError;
  double get precip => throw _privateConstructorUsedError;
  double get precipprob => throw _privateConstructorUsedError;
  int get datetimeEpoch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherCopyWith<Weather> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherCopyWith<$Res> {
  factory $WeatherCopyWith(Weather value, $Res Function(Weather) then) =
      _$WeatherCopyWithImpl<$Res, Weather>;
  @useResult
  $Res call(
      {double humidity,
      double temp,
      double precip,
      double precipprob,
      int datetimeEpoch});
}

/// @nodoc
class _$WeatherCopyWithImpl<$Res, $Val extends Weather>
    implements $WeatherCopyWith<$Res> {
  _$WeatherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? humidity = null,
    Object? temp = null,
    Object? precip = null,
    Object? precipprob = null,
    Object? datetimeEpoch = null,
  }) {
    return _then(_value.copyWith(
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as double,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double,
      precip: null == precip
          ? _value.precip
          : precip // ignore: cast_nullable_to_non_nullable
              as double,
      precipprob: null == precipprob
          ? _value.precipprob
          : precipprob // ignore: cast_nullable_to_non_nullable
              as double,
      datetimeEpoch: null == datetimeEpoch
          ? _value.datetimeEpoch
          : datetimeEpoch // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WeatherCopyWith<$Res> implements $WeatherCopyWith<$Res> {
  factory _$$_WeatherCopyWith(
          _$_Weather value, $Res Function(_$_Weather) then) =
      __$$_WeatherCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double humidity,
      double temp,
      double precip,
      double precipprob,
      int datetimeEpoch});
}

/// @nodoc
class __$$_WeatherCopyWithImpl<$Res>
    extends _$WeatherCopyWithImpl<$Res, _$_Weather>
    implements _$$_WeatherCopyWith<$Res> {
  __$$_WeatherCopyWithImpl(_$_Weather _value, $Res Function(_$_Weather) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? humidity = null,
    Object? temp = null,
    Object? precip = null,
    Object? precipprob = null,
    Object? datetimeEpoch = null,
  }) {
    return _then(_$_Weather(
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as double,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double,
      precip: null == precip
          ? _value.precip
          : precip // ignore: cast_nullable_to_non_nullable
              as double,
      precipprob: null == precipprob
          ? _value.precipprob
          : precipprob // ignore: cast_nullable_to_non_nullable
              as double,
      datetimeEpoch: null == datetimeEpoch
          ? _value.datetimeEpoch
          : datetimeEpoch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Weather implements _Weather {
  _$_Weather(
      {required this.humidity,
      required this.temp,
      required this.precip,
      required this.precipprob,
      required this.datetimeEpoch});

  factory _$_Weather.fromJson(Map<String, dynamic> json) =>
      _$$_WeatherFromJson(json);

  @override
  final double humidity;
  @override
  final double temp;
  @override
  final double precip;
  @override
  final double precipprob;
  @override
  final int datetimeEpoch;

  @override
  String toString() {
    return 'Weather(humidity: $humidity, temp: $temp, precip: $precip, precipprob: $precipprob, datetimeEpoch: $datetimeEpoch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Weather &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.precip, precip) || other.precip == precip) &&
            (identical(other.precipprob, precipprob) ||
                other.precipprob == precipprob) &&
            (identical(other.datetimeEpoch, datetimeEpoch) ||
                other.datetimeEpoch == datetimeEpoch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, humidity, temp, precip, precipprob, datetimeEpoch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeatherCopyWith<_$_Weather> get copyWith =>
      __$$_WeatherCopyWithImpl<_$_Weather>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeatherToJson(
      this,
    );
  }
}

abstract class _Weather implements Weather {
  factory _Weather(
      {required final double humidity,
      required final double temp,
      required final double precip,
      required final double precipprob,
      required final int datetimeEpoch}) = _$_Weather;

  factory _Weather.fromJson(Map<String, dynamic> json) = _$_Weather.fromJson;

  @override
  double get humidity;
  @override
  double get temp;
  @override
  double get precip;
  @override
  double get precipprob;
  @override
  int get datetimeEpoch;
  @override
  @JsonKey(ignore: true)
  _$$_WeatherCopyWith<_$_Weather> get copyWith =>
      throw _privateConstructorUsedError;
}
