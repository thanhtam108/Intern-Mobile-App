// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseDto _$BaseResponseDtoFromJson(Map<String, dynamic> json) =>
    BaseResponseDto(
      data: json['data'],
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
      meta: json['meta'],
    );

Map<String, dynamic> _$BaseResponseDtoToJson(BaseResponseDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'meta': instance.meta,
    };
