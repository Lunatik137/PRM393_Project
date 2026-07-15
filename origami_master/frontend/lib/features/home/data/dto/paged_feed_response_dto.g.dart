// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_feed_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedFeedResponseDto _$PagedFeedResponseDtoFromJson(
  Map<String, dynamic> json,
) => PagedFeedResponseDto(
  items: (json['items'] as List<dynamic>)
      .map((e) => FeedResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  hasMore: json['hasMore'] as bool,
);
