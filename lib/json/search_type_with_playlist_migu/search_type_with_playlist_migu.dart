import 'package:json_annotation/json_annotation.dart';

part 'search_type_with_playlist_migu.g.dart';

@JsonSerializable()
class SearchTypeWithPlaylistMigu extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchTypeWithPlaylistMigu(
    this.result,
    this.data,
  );

  factory SearchTypeWithPlaylistMigu.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchTypeWithPlaylistMiguFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchTypeWithPlaylistMiguToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'userId')
  String userId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'creator')
  Creator creator;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'trackCount')
  String trackCount;

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
    this.id,
    this.userId,
    this.name,
    this.creator,
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
  String id;

  @JsonKey(name: 'platform')
  String platform;

  Creator(
    this.nick,
    this.id,
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

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'al')
  Al al;

  @JsonKey(name: 'cId')
  String cId;

  @JsonKey(name: 'platform')
  String platform;

  @JsonKey(name: 'url')
  String url;

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
    this.url,
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
