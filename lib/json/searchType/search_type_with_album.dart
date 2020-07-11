import 'package:json_annotation/json_annotation.dart';

part 'search_type_with_album.g.dart';

@JsonSerializable()
class SearchTypeWithAlbum extends Object {
  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  Data data;

  SearchTypeWithAlbum(
    this.result,
    this.data,
  );

  factory SearchTypeWithAlbum.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchTypeWithAlbumFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchTypeWithAlbumToJson(this);
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

  @JsonKey(name: 'mid')
  String mid;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'platform')
  String platform;

  Content(
    this.name,
    this.id,
    this.mid,
    this.picUrl,
    this.publishTime,
    this.ar,
    this.platform,
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
