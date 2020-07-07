import 'package:json_annotation/json_annotation.dart'; 
  
part 'recommend_playlist.g.dart';


@JsonSerializable()
  class RecommendPlaylist extends Object {

  @JsonKey(name: 'result')
  int result;

  @JsonKey(name: 'data')
  List<Data> data;

  RecommendPlaylist(this.result,this.data,);

  factory RecommendPlaylist.fromJson(Map<String, dynamic> srcJson) => _$RecommendPlaylistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendPlaylistToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'id')
  int id;

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

  @JsonKey(name: 'listId')
  String listId;

  @JsonKey(name: 'platform')
  String platform;

  Data(this.id,this.name,this.cover,this.trackCount,this.playCount,this.desc,this.listId,this.platform,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
