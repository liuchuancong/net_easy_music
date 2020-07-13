// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_singer_qq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSingerQq _$SearchSingerQqFromJson(Map<String, dynamic> json) {
  return SearchSingerQq(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchSingerQqToJson(SearchSingerQq instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'] as String,
    json['mid'] as String,
    json['picUrl'] as String,
    (json['alias'] as List)?.map((e) => e as String)?.toList(),
    json['company'] as String,
    json['desc'] as String,
    (json['intro'] as List)
        ?.map(
            (e) => e == null ? null : Intro.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['platform'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'mid': instance.mid,
      'picUrl': instance.picUrl,
      'alias': instance.alias,
      'company': instance.company,
      'desc': instance.desc,
      'intro': instance.intro,
      'platform': instance.platform,
    };

Intro _$IntroFromJson(Map<String, dynamic> json) {
  return Intro(
    json['ti'] as String,
    json['txt'] as String,
  );
}

Map<String, dynamic> _$IntroToJson(Intro instance) => <String, dynamic>{
      'ti': instance.ti,
      'txt': instance.txt,
    };
