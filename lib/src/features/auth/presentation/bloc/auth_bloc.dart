import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/routes.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/navigation/kuick_navigation.dart';
import '../../../../core/utils/app_logs.dart' show Log;
import '../../service/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = sl<AuthService>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthCheckStatusEvent>(_onCheckStatus);
    on<AuthLogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.setUser(event.userData);
      Log.i(_authService.token, label: "Token");
      KuickNavigation.goNamed(KuickRoutes.workspace);
      emit(Authenticated(event.userData));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckStatus(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final user = _authService.getUser();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    await _authService.clearUser();
    emit(Unauthenticated());
  }
}
