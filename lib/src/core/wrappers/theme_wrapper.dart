import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/bloc/theme_bloc.dart';
import '../theme/bloc/theme_event.dart';
import '../theme/bloc/theme_state.dart';
import '../theme/theme_mode_enum.dart';

typedef ThemeBuilder =
    Widget Function(BuildContext context, ThemeMode themeMode);

/// ThemeWrapper listens to ThemeBloc and provides the current ThemeMode
/// to the builder callback.
class ThemeWrapper extends StatelessWidget {
  final ThemeBuilder builder;

  const ThemeWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc()..add(LoadTheme()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          ThemeMode themeMode;

          switch (state.themeMode) {
            case AppThemeMode.light:
              themeMode = ThemeMode.light;
              break;
            case AppThemeMode.dark:
              themeMode = ThemeMode.dark;
              break;
            case AppThemeMode.system:
              themeMode = ThemeMode.system;
          }

          return builder(context, themeMode);
        },
      ),
    );
  }
}
