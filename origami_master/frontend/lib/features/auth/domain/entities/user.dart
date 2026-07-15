import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? profilePictureUrl;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [id, username, email, profilePictureUrl];
}
