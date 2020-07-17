// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_playlist_qq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPlaylistQq _$SearchPlaylistQqFromJson(Map<String, dynamic> json) {
  return SearchPlaylistQq(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchPlaylistQqToJson(SearchPlaylistQq instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['name'] as String,
    json['id'],
    json['creator'] == null
        ? null
        : Creator.fromJson(json['creator'] as Map<String, dynamic>),
    json['cover'] as String,
    json['dirid'] as int,
    json['trackCount'] as int,
    json['desc'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Content.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['listId'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'creator': instance.creator,
      'cover': instance.cover,
      'dirid': instance.dirid,
      'trackCount': instance.trackCount,
      'desc': instance.desc,
      'list': instance.content,
      'listId': instance.listId,
      'platform': instance.platform,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return Creator(
    json['nick'] as String,
    json['avatar'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'nick': instance.nick,
      'avatar': instance.avatar,
      'platform': instance.platform,
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    json['name'] as String,
    json['id'] as String,
    json['songid'] as int,
    json['mid'] as String,
    json['mediaId'] as String,
    (json['ar'] as List)
        ?.map((e) => e == null ? null : Ar.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['mvId'] as String,
    json['al'] == null ? null : Al.fromJson(json['al'] as Map<String, dynamic>),
    json['duration'] as int,
    json['publishTime'] as int,
    json['platform'] as String,
    json['qqId'] as String,
    json['aId'] as String,
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'songid': instance.songid,
      'mid': instance.mid,
      'mediaId': instance.mediaId,
      'ar': instance.ar,
      'mvId': instance.mvId,
      'al': instance.al,
      'duration': instance.duration,
      'publishTime': instance.publishTime,
      'platform': instance.platform,
      'qqId': instance.qqId,
      'aId': instance.aId,
    };

Ar _$ArFromJson(Map<String, dynamic> json) {
  return Ar(
    json['id'],
    json['name'] as String,
    json['mid'] as String,
    json['picUrl'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$ArToJson(Ar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mid': instance.mid,
      'picUrl': instance.picUrl,
      'platform': instance.platform,
    };

Al _$AlFromJson(Map<String, dynamic> json) {
  return Al(
    json['name'] as String,
    json['id'],
    json['mid'] as String,
    json['picUrl'] as String,
    json['desc'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$AlToJson(Al instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'mid': instance.mid,
      'picUrl': instance.picUrl,
      'desc': instance.desc,
      'platform': instance.platform,
    };
