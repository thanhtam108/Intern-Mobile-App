import 'package:json_annotation/json_annotation.dart';

part 'base_response_dto.g.dart';

/// data : {"access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjIyLCJlbWFpbCI6InB2dGhpZW5kZXZlbG9wZXJAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE2NzIyOTcwNzYsImV4cCI6MTY3MjM4MzQ3Nn0.9QEo0OrhdkbJGLtGfPmWzKgPOQ15pL6bJcSYyeEAMrI","refresh_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjIyLCJlbWFpbCI6InB2dGhpZW5kZXZlbG9wZXJAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE2NzIyOTcwNzYsImV4cCI6MTY3MjkwMTg3Nn0.GxbpKTKPtXV9wZoR0ebDqHcIYER4n5Urs-Pz5bhzh54"}
/// message : "Success"
/// statusCode : 200

@JsonSerializable()
class BaseResponseDto {
  final dynamic data;
  final String? message;
  final bool? success;
  final dynamic meta;

  BaseResponseDto({this.data, this.message, this.success, this.meta});

  factory BaseResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseDtoToJson(this);
}
