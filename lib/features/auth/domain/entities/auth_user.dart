import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String phone;

  const AuthUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, email, name, phone];
}
