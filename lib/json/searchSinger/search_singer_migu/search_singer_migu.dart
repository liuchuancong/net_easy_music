import 'package:json_annotation/json_annotation.dart';

part 'search_singer_migu.g.dart';

@JsonSerializable()
class SearchSingerMigu extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchSingerMigu(
    this.result,
    this.data,
  );

  factory SearchSingerMigu.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchSingerMiguFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchSingerMiguToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'intro')
  List<Intro> intro;

  @JsonKey(name: 'platform')
  String platform;

  Data(
    this.id,
    this.name,
    this.picUrl,
    this.intro,
    this.platform,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Intro extends Object {
  @JsonKey(name: 'ti')
  String ti;

  @JsonKey(name: 'txt')
  String txt;

  Intro(
    this.ti,
    this.txt,
  );

  factory Intro.fromJson(Map<String, dynamic> srcJson) =>
      _$IntroFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IntroToJson(this);
}
