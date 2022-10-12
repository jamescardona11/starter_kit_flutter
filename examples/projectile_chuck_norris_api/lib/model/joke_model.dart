import 'package:json_annotation/json_annotation.dart';

part 'joke_model.g.dart';

@JsonSerializable()
class JokeModel {
  JokeModel({
    required this.categories,
    this.iconUrl,
    required this.id,
    required this.url,
    required this.value,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);

  String get category =>
      categories.isNotEmpty ? categories.join(',') : 'No Category';

  final List<String> categories;
  final String? iconUrl;
  final String id;
  final String url;
  final String value;
}
