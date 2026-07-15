import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Pagination<T> {
  final List<T> items;
  final int pageNumber;
  final int pageSize;
  final bool hasMore;

  Pagination({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.hasMore,
  });

  factory Pagination.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$PaginationToJson(this, toJsonT);
}
