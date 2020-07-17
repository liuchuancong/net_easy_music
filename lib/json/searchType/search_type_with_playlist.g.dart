// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_type_with_playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTypeWithPlaylist _$SearchTypeWithPlaylistFromJson(
    Map<String, dynamic> json) {
  return SearchTypeWithPlaylist(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchTypeWithPlaylistToJson(
        SearchTypeWithPlaylist instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Content.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['pageNo'] as String,
    json['pageSize'] as int,
    json['total'] as int,
    json['key'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'list': instance.content,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'total': instance.total,
      'key': instance.key,
      'type': instance.type,
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    json['name'] as String,
    json['id'],
    json['creator'] == null
        ? null
        : Creator.fromJson(json['creator'] as Map<String, dynamic>),
    json['userId'],
    json['cover'] as String,
    json['trackCount'] as int,
    json['playCount'] as int,
    json['desc'] as String,
    json['listId'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'creator': instance.creator,
      'userId': instance.userId,
      'cover': instance.cover,
      'trackCount': instance.trackCount,
      'playCount': instance.playCount,
      'desc': instance.desc,
      'listId': instance.listId,
      'platform': instance.platform,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return Creator(
    json['nick'] as String,
    json['id'],
    json['platform'] as String,
  );
}

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'nick': instance.nick,
      'id': instance.id,
      'platform': instance.platform,
    };
