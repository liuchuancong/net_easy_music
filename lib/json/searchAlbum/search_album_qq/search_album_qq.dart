import 'package:json_annotation/json_annotation.dart';

part 'search_album_qq.g.dart';

@JsonSerializable()
class SearchAlbumQq extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchAlbumQq(
    this.result,
    this.data,
  );

  factory SearchAlbumQq.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchAlbumQqFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchAlbumQqToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  dynamic id;

  @JsonKey(name: 'mid')
  String mid;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'company')
  String company;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'ar')
  List<Artlists> artlists;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'platform')
  String platform;

  @JsonKey(name: 'list')
  List<Content> content;

  Data(
    this.name,
    this.id,
    this.mid,
    this.picUrl,
    this.company,
    this.publishTime,
    this.artlists,
    this.desc,
    this.platform,
    this.content,
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

  @JsonKey(name: 'mid')
  String mid;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'platform')
  String platform;

  Artlists(
    this.id,
    this.name,
    this.mid,
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

  @JsonKey(name: 'songid')
  int songid;

  @JsonKey(name: 'mid')
  String mid;

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'mvId')
  String mvId;

  @JsonKey(name: 'al')
  Al al;

  @JsonKey(name: 'trackNo')
  int trackNo;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'platform')
  String platform;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'qqId')
  String qqId;

  @JsonKey(name: 'aId')
  String aId;

  Content(
    this.name,
    this.id,
    this.songid,
    this.mid,
    this.ar,
    this.mvId,
    this.al,
    this.trackNo,
    this.duration,
    this.publishTime,
    this.platform,
    this.url,
    this.qqId,
    this.aId,
  );

  factory Content.fromJson(Map<String, dynamic> srcJson) =>
      _$ContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Ar extends Object {
  @JsonKey(name: 'id')
  dynamic id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'mid')
  String mid;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'platform')
  String platform;

  Ar(
    this.id,
    this.name,
    this.mid,
    this.picUrl,
    this.platform,
  );

  factory Ar.fromJson(Map<String, dynamic> srcJson) => _$ArFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArToJson(this);
}

@JsonSerializable()
class Al extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  dynamic id;

  @JsonKey(name: 'mid')
  String mid;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'platform')
  String platform;

  Al(
    this.name,
    this.id,
    this.mid,
    this.picUrl,
    this.platform,
  );

  factory Al.fromJson(Map<String, dynamic> srcJson) => _$AlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlToJson(this);
}
