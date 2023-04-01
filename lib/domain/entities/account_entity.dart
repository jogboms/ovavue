import 'package:equatable/equatable.dart';

class AccountEntity with EquatableMixin {
  const AccountEntity({
    required this.id,
    required this.displayName,
    required this.email,
  });

  final String id;
  final String? displayName;
  final String email;

  @override
  List<Object?> get props => <Object?>[id, displayName, email];
}
