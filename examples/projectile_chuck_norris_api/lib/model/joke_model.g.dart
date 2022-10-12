// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeModel _$JokeModelFromJson(Map<String, dynamic> json) => JokeModel(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      iconUrl: json['iconUrl'] as String?,
      id: json['id'] as String,
      url: json['url'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$JokeModelToJson(JokeModel instance) => <String, dynamic>{
      'categories': instance.categories,
      'iconUrl': instance.iconUrl,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
    };
