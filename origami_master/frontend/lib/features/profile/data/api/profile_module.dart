import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'profile_api.dart';

@module
abstract class ProfileModule {
  @lazySingleton
  ProfileApi getProfileApi(Dio dio) => ProfileApi(dio);
}
