import 'package:equatable/equatable.dart';

class UpdateUserData with EquatableMixin {
  const UpdateUserData({
    required this.id,
    required this.lastSeenAt,
  });

  final String id;
  final DateTime lastSeenAt;

  @override
  List<Object?> get props => <Object?>[id, lastSeenAt];
}
