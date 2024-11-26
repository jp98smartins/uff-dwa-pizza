import '../../exports/exports.dart';
import 'token_entity.dart';
import 'user_entity.dart';

final class AuthEntity extends Equatable {
  final TokenEntity token;
  final UserEntity user;

  const AuthEntity({
    required this.token,
    required this.user,
  });
  
  @override
  List<Object?> get props => [token, user];
}
