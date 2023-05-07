import 'package:equatable/equatable.dart';

class AccountEntity with EquatableMixin {
  const AccountEntity({required this.id});

  final String id;

  @override
  List<Object?> get props => <Object?>[id];
}
