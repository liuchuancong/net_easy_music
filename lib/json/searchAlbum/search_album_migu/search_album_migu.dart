import 'package:json_annotation/json_annotation.dart';

part 'search_album_migu.g.dart';

@JsonSerializable()
class SearchAlbumMigu extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchAlbumMigu(
    this.result,
    this.data,
  );

  factory SearchAlbumMigu.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchAlbumMiguFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchAlbumMiguToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'artlists')
  List<Artlists> artlists;

  @JsonKey(name: 'content')
  List<Content> content;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'company')
  String company;

  @JsonKey(name: 'platform')
  String platform;

  Data(
    this.id,
    this.name,
    this.picUrl,
    this.publishTime,
    this.artlists,
    this.content,
    this.desc,
    this.company,
    this.platform,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Artlists extends Object {
  @JsonKey(name: 'id')
  String id;

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
  String id;

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'al')
  Al al;

  @JsonKey(name: 'cId')
  String cId;

  @JsonKey(name: 'platform')
  String platform;

  @JsonKey(name: 'miguId')
  String miguId;

  @JsonKey(name: 'aId')
  String aId;

  Content(
    this.name,
    this.id,
    this.ar,
    this.al,
    this.cId,
    this.platform,
    this.miguId,
    this.aId,
  );

  factory Content.fromJson(Map<String, dynamic> srcJson) =>
      _$ContentFromJson(srcJson);

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
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'platform')
  String platform;

  Al(
    this.id,
    this.name,
    this.platform,
  );

  factory Al.fromJson(Map<String, dynamic> srcJson) => _$AlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlToJson(this);
}
