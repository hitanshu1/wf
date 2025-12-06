import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuick_workflow/src/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/dashboard/presentation/bloc/workflow/workflow_bloc.dart';
import '../di/service_locator.dart';
import '../localization/bloc/locale_bloc.dart';
import '../localization/bloc/locale_event.dart';
import '../theme/bloc/theme_bloc.dart';
import '../theme/bloc/theme_event.dart';

class BlocProviderWrapper extends StatelessWidget {
  final Widget child;
  const BlocProviderWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (c) => sl<ThemeBloc>()..add(LoadTheme()),
        ),
        BlocProvider<LocaleBloc>(
          create: (c) => sl<LocaleBloc>()..add(LoadLocale()),
        ),
        BlocProvider(
          create: (c) => sl<AuthBloc>()..add(AuthCheckStatusEvent()),
        ),
        BlocProvider<WorkflowBloc>(
          create: (c) => WorkflowBloc(),
        ),
        BlocProvider<DashboardBloc>(
          create: (c) => DashboardBloc(),
        ),

      ],
      child: child,
    );
  }
}
