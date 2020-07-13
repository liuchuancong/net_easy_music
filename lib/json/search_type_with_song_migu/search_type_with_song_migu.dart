import 'package:json_annotation/json_annotation.dart'; 
  
part 'search_type_with_song_migu.g.dart';


@JsonSerializable()
  class SearchTypeWithSongMigu extends Object {

  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchTypeWithSongMigu(this.result,this.data,);

  factory SearchTypeWithSongMigu.fromJson(Map<String, dynamic> srcJson) => _$SearchTypeWithSongMiguFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchTypeWithSongMiguToJson(this);

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
  String id;

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'al')
  Al al;

  @JsonKey(name: 'cId')
  String cId;

  @JsonKey(name: 'mvId')
  String mvId;

  @JsonKey(name: 'platform')
  String platform;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'miguId')
  String miguId;

  @JsonKey(name: 'aId')
  String aId;

  Content(this.name,this.id,this.ar,this.al,this.cId,this.mvId,this.platform,this.url,this.miguId,this.aId,);

  factory Content.fromJson(Map<String, dynamic> srcJson) => _$ContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

}

  
@JsonSerializable()
  class Ar extends Object {

  @JsonKey(name: 'id')
  String id;

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
  String id;

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

  
