import 'package:json_annotation/json_annotation.dart';

part 'search_playlist_qq.g.dart';

@JsonSerializable()
class SearchPlaylistQq extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchPlaylistQq(
    this.result,
    this.data,
  );

  factory SearchPlaylistQq.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchPlaylistQqFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchPlaylistQqToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  dynamic id;

  @JsonKey(name: 'creator')
  Creator creator;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'dirid')
  int dirid;

  @JsonKey(name: 'trackCount')
  int trackCount;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'list')
  List<Content> content;

  @JsonKey(name: 'listId')
  String listId;

  @JsonKey(name: 'platform')
  String platform;

  Data(
    this.name,
    this.id,
    this.creator,
    this.cover,
    this.dirid,
    this.trackCount,
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

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'platform')
  String platform;

  Creator(
    this.nick,
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

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'platform')
  String platform;

  Al(
    this.name,
    this.id,
    this.mid,
    this.picUrl,
    this.desc,
    this.platform,
  );

  factory Al.fromJson(Map<String, dynamic> srcJson) => _$AlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlToJson(this);
}
