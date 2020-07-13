// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_type_with_singer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTypeWithSinger _$SearchTypeWithSingerFromJson(Map<String, dynamic> json) {
  return SearchTypeWithSinger(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchTypeWithSingerToJson(
        SearchTypeWithSinger instance) =>
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
    json['id'] as dynamic,
    json['name'] as String,
    json['mid'] as String,
    json['picUrl'] as String,
    json['platform'] as String,
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mid': instance.mid,
      'picUrl': instance.picUrl,
      'platform': instance.platform,
    };
