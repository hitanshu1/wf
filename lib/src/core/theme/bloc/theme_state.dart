import 'package:equatable/equatable.dart';
import '../theme_mode_enum.dart';

class ThemeState extends Equatable {
  final AppThemeMode themeMode;

  const ThemeState({required this.themeMode});

  ThemeState copyWith({AppThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object?> get props => [themeMode];
}
