import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme_mode_enum.dart';
import '../theme_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: AppThemeMode.system)) {
    on<LoadTheme>(_onLoadTheme);
    on<ChangeTheme>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final savedTheme = await ThemeService.getThemeMode();
    emit(state.copyWith(themeMode: savedTheme));
  }

  Future<void> _onChangeTheme(
    ChangeTheme event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.mode));
    await ThemeService.saveThemeMode(event.mode);
  }
}
