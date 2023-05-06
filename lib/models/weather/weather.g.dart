// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Weather _$$_WeatherFromJson(Map<String, dynamic> json) => _$_Weather(
      humidity: (json['humidity'] as num).toDouble(),
      temp: (json['temp'] as num).toDouble(),
      precip: (json['precip'] as num).toDouble(),
      precipprob: (json['precipprob'] as num).toDouble(),
      datetimeEpoch: json['datetimeEpoch'] as int,
    );

Map<String, dynamic> _$$_WeatherToJson(_$_Weather instance) =>
    <String, dynamic>{
      'humidity': instance.humidity,
      'temp': instance.temp,
      'precip': instance.precip,
      'precipprob': instance.precipprob,
      'datetimeEpoch': instance.datetimeEpoch,
    };
