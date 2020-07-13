import 'package:json_annotation/json_annotation.dart'; 
  
part 'search_type_with_song_netease.g.dart';


@JsonSerializable()
  class SearchTypeWithSongNetease extends Object {

  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchTypeWithSongNetease(this.result,this.data,);

  factory SearchTypeWithSongNetease.fromJson(Map<String, dynamic> srcJson) => _$SearchTypeWithSongNeteaseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchTypeWithSongNeteaseToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'list')
  List<Content> content;

  @JsonKey(name: 'pageNo')
  String pageNo;

  @JsonKey(name: 'pageSize')
  int pageSize;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'key')
  String key;

  @JsonKey(name: 'type')
  String type;

  Data(this.content,this.pageNo,this.pageSize,this.total,this.key,this.type,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Content extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'al')
  Al al;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'mvId')
  int mvId;

  @JsonKey(name: 'trackNo')
  int trackNo;

  @JsonKey(name: 'platform')
  String platform;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'aId')
  String aId;

  Content(this.name,this.id,this.ar,this.al,this.publishTime,this.mvId,this.trackNo,this.platform,this.duration,this.aId,);

  factory Content.fromJson(Map<String, dynamic> srcJson) => _$ContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

}

  
@JsonSerializable()
  class Ar extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'platform')
  String platform;

  Ar(this.id,this.name,this.picUrl,this.platform,);

  factory Ar.fromJson(Map<String, dynamic> srcJson) => _$ArFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArToJson(this);

}

  
@JsonSerializable()
  class Al extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'platform')
  String platform;

  Al(this.id,this.name,this.picUrl,this.platform,);

  factory Al.fromJson(Map<String, dynamic> srcJson) => _$AlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlToJson(this);

}

  
