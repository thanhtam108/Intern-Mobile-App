import 'package:json_annotation/json_annotation.dart';

part 'error_response_dto.g.dart';

/// data : {"access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjIyLCJlbWFpbCI6InB2dGhpZW5kZXZlbG9wZXJAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE2NzIyOTcwNzYsImV4cCI6MTY3MjM4MzQ3Nn0.9QEo0OrhdkbJGLtGfPmWzKgPOQ15pL6bJcSYyeEAMrI","refresh_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjIyLCJlbWFpbCI6InB2dGhpZW5kZXZlbG9wZXJAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE2NzIyOTcwNzYsImV4cCI6MTY3MjkwMTg3Nn0.GxbpKTKPtXV9wZoR0ebDqHcIYER4n5Urs-Pz5bhzh54"}
/// message : "Success"
/// statusCode : 200

@JsonSerializable()
class ErrorResponseDto {
  final String? message;
  final String? code;

  ErrorResponseDto({this.message, this.code});

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseDtoToJson(this);
}
