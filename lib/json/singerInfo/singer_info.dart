import 'package:json_annotation/json_annotation.dart'; 
  
part 'singer_info.g.dart';


@JsonSerializable()
  class SingerInfo extends Object {

  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SingerInfo(this.result,this.data,);

  factory SingerInfo.fromJson(Map<String, dynamic> srcJson) => _$SingerInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SingerInfoToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'id')
  dynamic id;

  @JsonKey(name: 'mid')
  String mid;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'alias')
  List<String> alias;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'intro')
  List<Intro> intro;

  @JsonKey(name: 'platform')
  String platform;

  Data(this.id,this.mid,this.picUrl,this.alias,this.desc,this.intro,this.platform,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Intro extends Object {

  @JsonKey(name: 'ti')
  String ti;

  @JsonKey(name: 'txt')
  String txt;

  Intro(this.ti,this.txt,);

  factory Intro.fromJson(Map<String, dynamic> srcJson) => _$IntroFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IntroToJson(this);

}

  
