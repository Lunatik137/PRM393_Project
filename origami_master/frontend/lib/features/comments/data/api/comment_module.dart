import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'comment_api.dart';

@module
abstract class CommentModule {
  @lazySingleton
  CommentApi getCommentApi(Dio dio) => CommentApi(dio);
}
