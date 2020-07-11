import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  Playlist(
    this.result,
    this.data,
  );

  factory Playlist.fromJson(Map<String, dynamic> srcJson) =>
      _$PlaylistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
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
  List<DataList> list;

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
    this.list,
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
class DataList extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  dynamic id;

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'al')
  Al al;

  @JsonKey(name: 'mvId')
  dynamic mvId;

  @JsonKey(name: 'trackNo')
  dynamic trackNo;

  @JsonKey(name: 'platform')
  dynamic platform;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'aId')
  dynamic aId;

  DataList(
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

  factory DataList.fromJson(Map<String, dynamic> srcJson) =>
      _$DataListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataListToJson(this);
}

@JsonSerializable()
class Ar extends Object {
  @JsonKey(name: 'id')
  dynamic id;

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
  dynamic id;

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
