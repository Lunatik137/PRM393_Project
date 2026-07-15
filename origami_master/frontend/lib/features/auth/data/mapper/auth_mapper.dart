import '../dto/login_response_dto.dart';
import '../dto/user_dto.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user.dart';

class AuthMapper {
  static User mapUser(UserDto dto) {
    return User(
      id: dto.id,
      username: dto.username,
      email: dto.email ?? '',
      profilePictureUrl: dto.profilePictureUrl,
    );
  }

  static AuthSession mapSession(LoginResponseDto dto) {
    return AuthSession(
      accessToken: dto.accessToken,
      refreshToken: dto.refreshToken,
      user: mapUser(dto.user),
    );
  }
}

