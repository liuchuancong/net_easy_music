// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_type_with_song_qq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTypeWithSongQq _$SearchTypeWithSongQqFromJson(Map<String, dynamic> json) {
  return SearchTypeWithSongQq(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchTypeWithSongQqToJson(
        SearchTypeWithSongQq instance) =>
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
    json['id'] as String,
    json['songid'] as int,
    json['mid'] as String,
    json['mediaId'] as String,
    (json['ar'] as List)
        ?.map((e) => e == null ? null : Ar.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['mvId'] as String,
    json['al'] == null ? null : Al.fromJson(json['al'] as Map<String, dynamic>),
    json['trackNo'] as int,
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
      'trackNo': instance.trackNo,
      'duration': instance.duration,
      'publishTime': instance.publishTime,
      'platform': instance.platform,
      'qqId': instance.qqId,
      'aId': instance.aId,
    };

Ar _$ArFromJson(Map<String, dynamic> json) {
  return Ar(
    json['id'] as int,
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
    json['id'] as int,
    json['mid'] as String,
    json['picUrl'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$AlToJson(Al instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'mid': instance.mid,
      'picUrl': instance.picUrl,
      'platform': instance.platform,
    };
