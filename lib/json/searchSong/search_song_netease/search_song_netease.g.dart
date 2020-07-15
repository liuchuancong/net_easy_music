// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_song_netease.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSongNetease _$SearchSongNeteaseFromJson(Map<String, dynamic> json) {
  return SearchSongNetease(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchSongNeteaseToJson(SearchSongNetease instance) =>
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
    (json['ar'] as List)
        ?.map((e) => e == null ? null : Ar.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['al'] == null ? null : Al.fromJson(json['al'] as Map<String, dynamic>),
    json['publishTime'] as int,
    json['mvId'] as int,
    json['trackNo'] as int,
    json['platform'] as String,
    json['duration'] as int,
    json['aId'] as String,
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'ar': instance.ar,
      'al': instance.al,
      'publishTime': instance.publishTime,
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
