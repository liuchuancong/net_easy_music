import 'package:json_annotation/json_annotation.dart';

part 'search_singer_qq.g.dart';

@JsonSerializable()
class SearchSingerQq extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchSingerQq(
    this.result,
    this.data,
  );

  factory SearchSingerQq.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchSingerQqFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchSingerQqToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'mid')
  String mid;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'alias')
  List<String> alias;

  @JsonKey(name: 'company')
  String company;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'intro')
  List<Intro> intro;

  @JsonKey(name: 'platform')
  String platform;

  Data(
    this.id,
    this.mid,
    this.picUrl,
    this.alias,
    this.company,
    this.desc,
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
