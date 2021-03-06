// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return Playlist(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['creator'] == null
        ? null
        : Creator.fromJson(json['creator'] as Map<String, dynamic>),
    json['id'],
    json['userId'] as int,
    json['name'] as String,
    json['cover'] as String,
    json['trackCount'] as int,
    json['playCount'] as int,
    json['desc'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : DataList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['listId'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'creator': instance.creator,
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'cover': instance.cover,
      'trackCount': instance.trackCount,
      'playCount': instance.playCount,
      'desc': instance.desc,
      'list': instance.list,
      'listId': instance.listId,
      'platform': instance.platform,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return Creator(
    json['nick'] as String,
    json['id'],
    json['avatar'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'nick': instance.nick,
      'id': instance.id,
      'avatar': instance.avatar,
      'platform': instance.platform,
    };

DataList _$DataListFromJson(Map<String, dynamic> json) {
  return DataList(
    json['name'] as String,
    json['id'],
    (json['ar'] as List)
        ?.map((e) => e == null ? null : Ar.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['al'] == null ? null : Al.fromJson(json['al'] as Map<String, dynamic>),
    json['mvId'],
    json['trackNo'],
    json['platform'],
    json['duration'] as int,
    json['aId'],
  );
}

Map<String, dynamic> _$DataListToJson(DataList instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'ar': instance.ar,
      'al': instance.al,
      'mvId': instance.mvId,
      'trackNo': instance.trackNo,
      'platform': instance.platform,
      'duration': instance.duration,
      'aId': instance.aId,
    };

Ar _$ArFromJson(Map<String, dynamic> json) {
  return Ar(
    json['id'],
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
    json['id'],
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
