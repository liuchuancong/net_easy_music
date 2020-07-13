// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_playlist_migu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPlaylistMigu _$SearchPlaylistMiguFromJson(Map<String, dynamic> json) {
  return SearchPlaylistMigu(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchPlaylistMiguToJson(SearchPlaylistMigu instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'] as String,
    json['userId'] as String,
    json['name'] as String,
    json['creator'] == null
        ? null
        : Creator.fromJson(json['creator'] as Map<String, dynamic>),
    json['cover'] as String,
    json['trackCount'] as String,
    json['playCount'] as int,
    json['desc'] as String,
    (json['content'] as List)
        ?.map((e) =>
            e == null ? null : Content.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['listId'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'creator': instance.creator,
      'cover': instance.cover,
      'trackCount': instance.trackCount,
      'playCount': instance.playCount,
      'desc': instance.desc,
      'content': instance.content,
      'listId': instance.listId,
      'platform': instance.platform,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return Creator(
    json['nick'] as String,
    json['id'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'nick': instance.nick,
      'id': instance.id,
      'platform': instance.platform,
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    json['name'] as String,
    json['id'] as String,
    (json['ar'] as List)
        ?.map((e) => e == null ? null : Ar.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['al'] == null ? null : Al.fromJson(json['al'] as Map<String, dynamic>),
    json['cId'] as String,
    json['platform'] as String,
    json['url'] as String,
    json['miguId'] as String,
    json['aId'] as String,
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'ar': instance.ar,
      'al': instance.al,
      'cId': instance.cId,
      'platform': instance.platform,
      'url': instance.url,
      'miguId': instance.miguId,
      'aId': instance.aId,
    };

Ar _$ArFromJson(Map<String, dynamic> json) {
  return Ar(
    json['id'] as String,
    json['name'] as String,
    json['picUrl'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$ArToJson(Ar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'platform': instance.platform,
    };

Al _$AlFromJson(Map<String, dynamic> json) {
  return Al(
    json['id'] as String,
    json['name'] as String,
    json['picUrl'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$AlToJson(Al instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'platform': instance.platform,
    };
