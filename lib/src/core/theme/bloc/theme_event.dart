import 'package:equatable/equatable.dart';
import '../theme_mode_enum.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered to load saved theme (system/light/dark)
class LoadTheme extends ThemeEvent {}

/// Triggered to change theme dynamically
class ChangeTheme extends ThemeEvent {
  final AppThemeMode mode;

  const ChangeTheme(this.mode);

  @override
  List<Object?> get props => [mode];
}
