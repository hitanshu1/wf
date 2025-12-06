// lib/src/features/auth/presentation/bloc/auth_event.dart

import 'package:equatable/equatable.dart';
import '../../../../core/stubs/kuick_authflow_stub.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered after successful login
class AuthLoginEvent extends AuthEvent {
  final LoginModel userData;
  const AuthLoginEvent(this.userData);

  @override
  List<Object?> get props => [userData];
}

/// Check if already logged in
class AuthCheckStatusEvent extends AuthEvent {}

/// Logout event
class AuthLogoutEvent extends AuthEvent {}
