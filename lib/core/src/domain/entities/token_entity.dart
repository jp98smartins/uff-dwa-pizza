import '../../exports/exports.dart';

final class TokenEntity extends Equatable {
  final String value;

  const TokenEntity({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}
