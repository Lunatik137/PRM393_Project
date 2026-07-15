import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/upload_response_dto.dart';

part 'upload_api.g.dart';

@RestApi()
abstract class UploadApi {
  factory UploadApi(Dio dio, {String baseUrl}) = _UploadApi;

  @POST('/upload/image')
  @MultiPart()
  Future<UploadResponseDto> uploadImage(
    @Part(name: "file") File file,
  );
}

