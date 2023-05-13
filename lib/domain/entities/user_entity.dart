import 'package:equatable/equatable.dart';

class UserEntity with EquatableMixin {
  const UserEntity({
    required this.id,
    required this.path,
    required this.createdAt,
  });

  final String id;
  final String path;
  final DateTime createdAt;

  @override
  List<Object> get props => <Object>[id, path, createdAt];
}
