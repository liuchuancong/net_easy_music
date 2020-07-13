import 'package:json_annotation/json_annotation.dart';

part 'search_playlist_netease.g.dart';

@JsonSerializable()
class SearchPlaylistNetease extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchPlaylistNetease(
    this.result,
    this.data,
  );

  factory SearchPlaylistNetease.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchPlaylistNeteaseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchPlaylistNeteaseToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'creator')
  Creator creator;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'trackCount')
  int trackCount;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'list')
  List<Content> content;

  @JsonKey(name: 'listId')
  String listId;

  @JsonKey(name: 'platform')
  String platform;

  Data(
    this.creator,
    this.id,
    this.userId,
    this.name,
    this.cover,
    this.trackCount,
    this.playCount,
    this.desc,
    this.content,
    this.listId,
    this.platform,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Creator extends Object {
  @JsonKey(name: 'nick')
  String nick;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'platform')
  String platform;

  Creator(
    this.nick,
    this.id,
    this.avatar,
    this.platform,
  );

  factory Creator.fromJson(Map<String, dynamic> srcJson) =>
      _$CreatorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CreatorToJson(this);
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

  Content(
    this.name,
    this.id,
    this.ar,
    this.al,
    this.publishTime,
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
