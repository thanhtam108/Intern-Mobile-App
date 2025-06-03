// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseDto _$ErrorResponseDtoFromJson(Map<String, dynamic> json) =>
    ErrorResponseDto(
      message: json['message'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$ErrorResponseDtoToJson(ErrorResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };
