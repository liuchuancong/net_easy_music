// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_album_migu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAlbumMigu _$SearchAlbumMiguFromJson(Map<String, dynamic> json) {
  return SearchAlbumMigu(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchAlbumMiguToJson(SearchAlbumMigu instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'] as String,
    json['name'] as String,
    json['picUrl'] as String,
    json['publishTime'] as int,
    (json['ar'] as List)
        ?.map((e) =>
            e == null ? null : Artlists.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Content.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['desc'] as String,
    json['company'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'publishTime': instance.publishTime,
      'ar': instance.artlists,
      'list': instance.content,
      'desc': instance.desc,
      'company': instance.company,
      'platform': instance.platform,
    };

Artlists _$ArtlistsFromJson(Map<String, dynamic> json) {
  return Artlists(
    json['id'] as String,
    json['name'] as String,
    json['picUrl'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$ArtlistsToJson(Artlists instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
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
    json['platform'] as String,
  );
}

Map<String, dynamic> _$AlToJson(Al instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'platform': instance.platform,
    };
