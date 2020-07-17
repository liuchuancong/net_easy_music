import 'package:json_annotation/json_annotation.dart';

part 'search_type_with_playlist.g.dart';

@JsonSerializable()
class SearchTypeWithPlaylist extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchTypeWithPlaylist(
    this.result,
    this.data,
  );

  factory SearchTypeWithPlaylist.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchTypeWithPlaylistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchTypeWithPlaylistToJson(this);
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
  dynamic id;

  @JsonKey(name: 'creator')
  Creator creator;

  @JsonKey(name: 'userId')
  dynamic userId;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'trackCount')
  int trackCount;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'listId')
  String listId;

  @JsonKey(name: 'platform')
  String platform;

  Content(
    this.name,
    this.id,
    this.creator,
    this.userId,
    this.cover,
    this.trackCount,
    this.playCount,
    this.desc,
    this.listId,
    this.platform,
  );

  factory Content.fromJson(Map<String, dynamic> srcJson) =>
      _$ContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Creator extends Object {
  @JsonKey(name: 'nick')
  String nick;

  @JsonKey(name: 'id')
  dynamic id;

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
