// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/api/auth_api.dart' as _i302;
import '../../features/auth/data/api/auth_module.dart' as _i434;
import '../../features/auth/data/datasource/auth_remote_datasource.dart'
    as _i175;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/check_session.dart' as _i625;
import '../../features/auth/domain/usecases/google_login.dart' as _i434;
import '../../features/auth/domain/usecases/login.dart' as _i428;
import '../../features/auth/domain/usecases/logout.dart' as _i597;
import '../../features/auth/domain/usecases/refresh_token.dart' as _i209;
import '../../features/auth/domain/usecases/register.dart' as _i480;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/comments/data/api/comment_api.dart' as _i183;
import '../../features/comments/data/api/comment_module.dart' as _i352;
import '../../features/comments/data/datasource/comment_remote_datasource.dart'
    as _i361;
import '../../features/comments/data/repository/comment_repository_impl.dart'
    as _i262;
import '../../features/comments/domain/repositories/comment_repository.dart'
    as _i79;
import '../../features/comments/domain/usecases/add_comment.dart' as _i813;
import '../../features/comments/domain/usecases/delete_comment.dart' as _i640;
import '../../features/comments/domain/usecases/get_comments.dart' as _i109;
import '../../features/comments/presentation/bloc/comment_bloc.dart' as _i715;
import '../../features/follow/data/api/follow_api.dart' as _i284;
import '../../features/follow/data/api/follow_module.dart' as _i114;
import '../../features/follow/data/datasource/follow_remote_datasource.dart'
    as _i674;
import '../../features/follow/data/repository/follow_repository_impl.dart'
    as _i257;
import '../../features/follow/domain/repositories/follow_repository.dart'
    as _i760;
import '../../features/follow/domain/usecases/follow_user.dart' as _i757;
import '../../features/follow/domain/usecases/get_followers.dart' as _i1027;
import '../../features/follow/domain/usecases/get_following.dart' as _i495;
import '../../features/follow/domain/usecases/unfollow_user.dart' as _i31;
import '../../features/follow/presentation/bloc/follow_bloc.dart' as _i568;
import '../../features/gallery/data/api/gallery_api.dart' as _i866;
import '../../features/gallery/data/api/gallery_module.dart' as _i170;
import '../../features/gallery/data/datasource/gallery_remote_datasource.dart'
    as _i1034;
import '../../features/gallery/data/repository/gallery_repository_impl.dart'
    as _i1022;
import '../../features/gallery/domain/repositories/gallery_repository.dart'
    as _i662;
import '../../features/gallery/domain/usecases/create_gallery.dart' as _i368;
import '../../features/gallery/domain/usecases/delete_gallery.dart' as _i944;
import '../../features/gallery/domain/usecases/get_gallery.dart' as _i698;
import '../../features/gallery/domain/usecases/get_my_posts_gallery.dart'
    as _i32;
import '../../features/gallery/domain/usecases/update_gallery.dart' as _i170;
import '../../features/gallery/domain/usecases/update_visibility.dart' as _i85;
import '../../features/gallery/presentation/bloc/gallery_bloc.dart' as _i812;
import '../../features/home/data/api/feed_api.dart' as _i26;
import '../../features/home/data/api/feed_module.dart' as _i444;
import '../../features/home/data/api/search_api.dart' as _i113;
import '../../features/home/data/api/search_module.dart' as _i59;
import '../../features/home/data/datasource/feed_remote_datasource.dart'
    as _i484;
import '../../features/home/data/repository/feed_repository_impl.dart' as _i779;
import '../../features/home/domain/repositories/feed_repository.dart' as _i954;
import '../../features/home/domain/usecases/get_feed.dart' as _i1017;
import '../../features/home/domain/usecases/like_post.dart' as _i58;
import '../../features/home/domain/usecases/unlike_post.dart' as _i432;
import '../../features/home/presentation/bloc/feed_bloc.dart' as _i924;
import '../../features/profile/data/api/profile_api.dart' as _i301;
import '../../features/profile/data/api/profile_module.dart' as _i898;
import '../../features/profile/data/datasource/profile_remote_datasource.dart'
    as _i1031;
import '../../features/profile/data/repository/profile_repository_impl.dart'
    as _i309;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/get_profile.dart' as _i72;
import '../../features/profile/domain/usecases/get_user_posts.dart' as _i233;
import '../../features/profile/presentation/bloc/profile_bloc.dart' as _i469;
import '../../features/share/data/api/share_api.dart' as _i341;
import '../../features/share/data/api/share_module.dart' as _i129;
import '../../features/share/data/datasource/share_remote_datasource.dart'
    as _i176;
import '../../features/share/data/repository/share_repository_impl.dart'
    as _i692;
import '../../features/share/domain/repositories/share_repository.dart'
    as _i108;
import '../../features/share/domain/usecases/delete_share_link.dart' as _i167;
import '../../features/share/domain/usecases/generate_share_link.dart' as _i456;
import '../../features/share/domain/usecases/get_shared_creation.dart' as _i540;
import '../../features/share/domain/usecases/get_shared_links.dart' as _i376;
import '../../features/share/domain/usecases/toggle_share_link.dart' as _i1045;
import '../../features/share/presentation/bloc/share_bloc.dart' as _i662;
import '../../features/upload/data/api/upload_api.dart' as _i579;
import '../../features/upload/data/api/upload_module.dart' as _i952;
import '../../features/upload/data/datasource/upload_remote_datasource.dart'
    as _i630;
import '../../features/upload/data/repository/upload_repository_impl.dart'
    as _i469;
import '../../features/upload/domain/repositories/upload_repository.dart'
    as _i302;
import '../../features/upload/domain/usecases/upload_image.dart' as _i672;
import '../../features/upload/presentation/bloc/upload_bloc.dart' as _i809;
import '../auth/token_manager.dart' as _i428;
import '../network/api_client.dart' as _i557;
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import '../repositories/origami_repository.dart' as _i665;
import '../storage/secure_storage_service.dart' as _i666;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    final dioModule = _$DioModule();
    final authModule = _$AuthModule();
    final commentModule = _$CommentModule();
    final followModule = _$FollowModule();
    final galleryModule = _$GalleryModule();
    final feedModule = _$FeedModule();
    final searchModule = _$SearchModule();
    final profileModule = _$ProfileModule();
    final shareModule = _$ShareModule();
    final uploadModule = _$UploadModule();
    gh.singleton<_i666.SecureStorageService>(
      () => _i666.SecureStorageService(),
    );
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.singleton<_i428.TokenManager>(
      () => _i428.TokenManager(gh<_i666.SecureStorageService>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.getDio(gh<_i428.TokenManager>(), gh<_i932.NetworkInfo>()),
    );
    gh.lazySingleton<_i557.ApiClient>(
      () => networkModule.getApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i302.AuthApi>(
      () => authModule.getAuthApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i183.CommentApi>(
      () => commentModule.getCommentApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i284.FollowApi>(
      () => followModule.getFollowApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i866.GalleryApi>(
      () => galleryModule.getGalleryApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i26.FeedApi>(
      () => feedModule.getFeedApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i113.SearchApi>(
      () => searchModule.getSearchApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i301.ProfileApi>(
      () => profileModule.getProfileApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i341.ShareApi>(
      () => shareModule.getShareApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i579.UploadApi>(
      () => uploadModule.getUploadApi(gh<_i361.Dio>()),
    );
    gh.factory<_i665.OrigamiRepository>(
      () => _i665.OrigamiRepositoryImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i175.AuthRemoteDataSource>(
      () => _i175.AuthRemoteDataSourceImpl(gh<_i302.AuthApi>()),
    );
    gh.lazySingleton<_i484.FeedRemoteDataSource>(
      () => _i484.FeedRemoteDataSourceImpl(gh<_i26.FeedApi>()),
    );
    gh.lazySingleton<_i954.FeedRepository>(
      () => _i779.FeedRepositoryImpl(gh<_i484.FeedRemoteDataSource>()),
    );
    gh.lazySingleton<_i1034.GalleryRemoteDataSource>(
      () => _i1034.GalleryRemoteDataSourceImpl(gh<_i866.GalleryApi>()),
    );
    gh.factory<_i1017.GetFeedUseCase>(
      () => _i1017.GetFeedUseCase(gh<_i954.FeedRepository>()),
    );
    gh.factory<_i58.LikePostUseCase>(
      () => _i58.LikePostUseCase(gh<_i954.FeedRepository>()),
    );
    gh.factory<_i432.UnlikePostUseCase>(
      () => _i432.UnlikePostUseCase(gh<_i954.FeedRepository>()),
    );
    gh.lazySingleton<_i630.UploadRemoteDataSource>(
      () => _i630.UploadRemoteDataSourceImpl(gh<_i579.UploadApi>()),
    );
    gh.lazySingleton<_i674.FollowRemoteDataSource>(
      () => _i674.FollowRemoteDataSourceImpl(gh<_i284.FollowApi>()),
    );
    gh.lazySingleton<_i760.FollowRepository>(
      () => _i257.FollowRepositoryImpl(gh<_i674.FollowRemoteDataSource>()),
    );
    gh.lazySingleton<_i1031.ProfileRemoteDataSource>(
      () => _i1031.ProfileRemoteDataSourceImpl(gh<_i301.ProfileApi>()),
    );
    gh.factory<_i757.FollowUserUseCase>(
      () => _i757.FollowUserUseCase(gh<_i760.FollowRepository>()),
    );
    gh.factory<_i1027.GetFollowersUseCase>(
      () => _i1027.GetFollowersUseCase(gh<_i760.FollowRepository>()),
    );
    gh.factory<_i495.GetFollowingUseCase>(
      () => _i495.GetFollowingUseCase(gh<_i760.FollowRepository>()),
    );
    gh.factory<_i31.UnfollowUserUseCase>(
      () => _i31.UnfollowUserUseCase(gh<_i760.FollowRepository>()),
    );
    gh.lazySingleton<_i361.CommentRemoteDataSource>(
      () => _i361.CommentRemoteDataSourceImpl(gh<_i183.CommentApi>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i409.AuthRepositoryImpl(
        gh<_i175.AuthRemoteDataSource>(),
        gh<_i428.TokenManager>(),
      ),
    );
    gh.factory<_i176.ShareRemoteDataSource>(
      () => _i176.ShareRemoteDataSourceImpl(gh<_i341.ShareApi>()),
    );
    gh.factory<_i625.CheckSessionUseCase>(
      () => _i625.CheckSessionUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i434.GoogleLoginUseCase>(
      () => _i434.GoogleLoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i428.LoginUseCase>(
      () => _i428.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i597.LogoutUseCase>(
      () => _i597.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i209.RefreshTokenUseCase>(
      () => _i209.RefreshTokenUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i480.RegisterUseCase>(
      () => _i480.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i302.UploadRepository>(
      () => _i469.UploadRepositoryImpl(gh<_i630.UploadRemoteDataSource>()),
    );
    gh.lazySingleton<_i894.ProfileRepository>(
      () => _i309.ProfileRepositoryImpl(gh<_i1031.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i662.GalleryRepository>(
      () => _i1022.GalleryRepositoryImpl(gh<_i1034.GalleryRemoteDataSource>()),
    );
    gh.factory<_i924.FeedBloc>(
      () => _i924.FeedBloc(
        gh<_i1017.GetFeedUseCase>(),
        gh<_i58.LikePostUseCase>(),
        gh<_i432.UnlikePostUseCase>(),
      ),
    );
    gh.factory<_i568.FollowBloc>(
      () => _i568.FollowBloc(
        gh<_i757.FollowUserUseCase>(),
        gh<_i31.UnfollowUserUseCase>(),
        gh<_i1027.GetFollowersUseCase>(),
        gh<_i495.GetFollowingUseCase>(),
      ),
    );
    gh.factory<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        gh<_i428.LoginUseCase>(),
        gh<_i434.GoogleLoginUseCase>(),
        gh<_i480.RegisterUseCase>(),
        gh<_i597.LogoutUseCase>(),
        gh<_i209.RefreshTokenUseCase>(),
        gh<_i625.CheckSessionUseCase>(),
      ),
    );
    gh.factory<_i108.ShareRepository>(
      () => _i692.ShareRepositoryImpl(gh<_i176.ShareRemoteDataSource>()),
    );
    gh.lazySingleton<_i79.CommentRepository>(
      () => _i262.CommentRepositoryImpl(gh<_i361.CommentRemoteDataSource>()),
    );
    gh.factory<_i72.GetProfileUseCase>(
      () => _i72.GetProfileUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i233.GetUserPostsUseCase>(
      () => _i233.GetUserPostsUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i469.ProfileBloc>(
      () => _i469.ProfileBloc(
        gh<_i72.GetProfileUseCase>(),
        gh<_i233.GetUserPostsUseCase>(),
      ),
    );
    gh.factory<_i672.UploadImageUseCase>(
      () => _i672.UploadImageUseCase(gh<_i302.UploadRepository>()),
    );
    gh.factory<_i368.CreateGalleryUseCase>(
      () => _i368.CreateGalleryUseCase(gh<_i662.GalleryRepository>()),
    );
    gh.factory<_i944.DeleteGalleryUseCase>(
      () => _i944.DeleteGalleryUseCase(gh<_i662.GalleryRepository>()),
    );
    gh.factory<_i698.GetGalleryUseCase>(
      () => _i698.GetGalleryUseCase(gh<_i662.GalleryRepository>()),
    );
    gh.factory<_i32.GetMyPostsGalleryUseCase>(
      () => _i32.GetMyPostsGalleryUseCase(gh<_i662.GalleryRepository>()),
    );
    gh.factory<_i170.UpdateGalleryUseCase>(
      () => _i170.UpdateGalleryUseCase(gh<_i662.GalleryRepository>()),
    );
    gh.factory<_i85.UpdateVisibilityUseCase>(
      () => _i85.UpdateVisibilityUseCase(gh<_i662.GalleryRepository>()),
    );
    gh.factory<_i167.DeleteShareLinkUseCase>(
      () => _i167.DeleteShareLinkUseCase(gh<_i108.ShareRepository>()),
    );
    gh.factory<_i456.GenerateShareLinkUseCase>(
      () => _i456.GenerateShareLinkUseCase(gh<_i108.ShareRepository>()),
    );
    gh.factory<_i540.GetSharedCreationUseCase>(
      () => _i540.GetSharedCreationUseCase(gh<_i108.ShareRepository>()),
    );
    gh.factory<_i376.GetSharedLinksUseCase>(
      () => _i376.GetSharedLinksUseCase(gh<_i108.ShareRepository>()),
    );
    gh.factory<_i1045.ToggleShareLinkUseCase>(
      () => _i1045.ToggleShareLinkUseCase(gh<_i108.ShareRepository>()),
    );
    gh.factory<_i662.ShareBloc>(
      () => _i662.ShareBloc(
        gh<_i456.GenerateShareLinkUseCase>(),
        gh<_i376.GetSharedLinksUseCase>(),
        gh<_i167.DeleteShareLinkUseCase>(),
        gh<_i1045.ToggleShareLinkUseCase>(),
        gh<_i540.GetSharedCreationUseCase>(),
      ),
    );
    gh.factory<_i813.AddCommentUseCase>(
      () => _i813.AddCommentUseCase(gh<_i79.CommentRepository>()),
    );
    gh.factory<_i640.DeleteCommentUseCase>(
      () => _i640.DeleteCommentUseCase(gh<_i79.CommentRepository>()),
    );
    gh.factory<_i109.GetCommentsUseCase>(
      () => _i109.GetCommentsUseCase(gh<_i79.CommentRepository>()),
    );
    gh.factory<_i809.UploadBloc>(
      () => _i809.UploadBloc(gh<_i672.UploadImageUseCase>()),
    );
    gh.factory<_i812.GalleryBloc>(
      () => _i812.GalleryBloc(
        gh<_i698.GetGalleryUseCase>(),
        gh<_i32.GetMyPostsGalleryUseCase>(),
        gh<_i368.CreateGalleryUseCase>(),
        gh<_i170.UpdateGalleryUseCase>(),
        gh<_i944.DeleteGalleryUseCase>(),
        gh<_i85.UpdateVisibilityUseCase>(),
        gh<_i672.UploadImageUseCase>(),
      ),
    );
    gh.factory<_i715.CommentBloc>(
      () => _i715.CommentBloc(
        gh<_i109.GetCommentsUseCase>(),
        gh<_i813.AddCommentUseCase>(),
        gh<_i640.DeleteCommentUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i567.NetworkModule {}

class _$DioModule extends _i667.DioModule {}

class _$AuthModule extends _i434.AuthModule {}

class _$CommentModule extends _i352.CommentModule {}

class _$FollowModule extends _i114.FollowModule {}

class _$GalleryModule extends _i170.GalleryModule {}

class _$FeedModule extends _i444.FeedModule {}

class _$SearchModule extends _i59.SearchModule {}

class _$ProfileModule extends _i898.ProfileModule {}

class _$ShareModule extends _i129.ShareModule {}

class _$UploadModule extends _i952.UploadModule {}
