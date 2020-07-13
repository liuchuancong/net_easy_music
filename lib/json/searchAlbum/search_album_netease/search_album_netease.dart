import 'package:json_annotation/json_annotation.dart';

part 'search_album_netease.g.dart';

@JsonSerializable()
class SearchAlbumNetease extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchAlbumNetease(
    this.result,
    this.data,
  );

  factory SearchAlbumNetease.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchAlbumNeteaseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchAlbumNeteaseToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'company')
  String company;

  @JsonKey(name: 'platform')
  String platform;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'cId')
  int cId;

  @JsonKey(name: 'artlists')
  List<Artlists> artlists;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'content')
  List<Content> content;

  Data(
    this.id,
    this.name,
    this.picUrl,
    this.company,
    this.platform,
    this.publishTime,
    this.cId,
    this.artlists,
    this.desc,
    this.content,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Artlists extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'platform')
  String platform;

  Artlists(
    this.id,
    this.name,
    this.picUrl,
    this.platform,
  );

  factory Artlists.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtlistsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtlistsToJson(this);
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

  Content(
    this.name,
    this.id,
    this.ar,
    this.al,
    this.mvId,
    this.trackNo,
    this.platform,
    this.duration,
    this.aId,
  );

  factory Content.fromJson(Map<String, dynamic> srcJson) =>
      _$ContentFromJson(srcJson);

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

  Ar(
    this.id,
    this.name,
    this.picUrl,
    this.platform,
  );

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

  Al(
    this.id,
    this.name,
    this.picUrl,
    this.platform,
  );

  factory Al.fromJson(Map<String, dynamic> srcJson) => _$AlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlToJson(this);
}
