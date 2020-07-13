// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_singer_migu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSingerMigu _$SearchSingerMiguFromJson(Map<String, dynamic> json) {
  return SearchSingerMigu(
    json['result'] as int,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchSingerMiguToJson(SearchSingerMigu instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'] as String,
    json['name'] as String,
    json['picUrl'] as String,
    (json['intro'] as List)
        ?.map(
            (e) => e == null ? null : Intro.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['platform'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
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
