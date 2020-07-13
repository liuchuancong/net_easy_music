import 'package:json_annotation/json_annotation.dart';

part 'search_song_qq.g.dart';

@JsonSerializable()
class SearchSongQq extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchSongQq(
    this.result,
    this.data,
  );

  factory SearchSongQq.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchSongQqFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchSongQqToJson(this);
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

  Data(
    this.content,
    this.pageNo,
    this.pageSize,
    this.total,
    this.key,
    this.type,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
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

  @JsonKey(name: 'mediaId')
  String mediaId;

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

  @JsonKey(name: 'qqId')
  String qqId;

  @JsonKey(name: 'aId')
  String aId;

  Content(
    this.name,
    this.id,
    this.songid,
    this.mid,
    this.mediaId,
    this.ar,
    this.mvId,
    this.al,
    this.trackNo,
    this.duration,
    this.publishTime,
    this.platform,
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
  int id;

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
  int id;

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
