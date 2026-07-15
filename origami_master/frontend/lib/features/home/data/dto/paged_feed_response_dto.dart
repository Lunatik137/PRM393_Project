import 'package:json_annotation/json_annotation.dart';
import 'feed_response_dto.dart';
part 'paged_feed_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class PagedFeedResponseDto {
  final List<FeedResponseDto> items;
  final int pageNumber;
  final int pageSize;
  final bool hasMore;

  PagedFeedResponseDto({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.hasMore,
  });

  factory PagedFeedResponseDto.fromJson(Map<String, dynamic> json) => _$PagedFeedResponseDtoFromJson(json);
}
