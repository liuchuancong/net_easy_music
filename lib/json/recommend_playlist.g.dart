// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendPlaylist _$RecommendPlaylistFromJson(Map<String, dynamic> json) {
  return RecommendPlaylist(
    json['result'] as int,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecommendPlaylistToJson(RecommendPlaylist instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'],
    json['name'] as String,
    json['cover'] as String,
    json['trackCount'] as int,
    json['playCount'] as int,
    json['desc'] as String,
    json['listId'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cover': instance.cover,
      'trackCount': instance.trackCount,
      'playCount': instance.playCount,
      'desc': instance.desc,
      'listId': instance.listId,
      'platform': instance.platform,
    };
