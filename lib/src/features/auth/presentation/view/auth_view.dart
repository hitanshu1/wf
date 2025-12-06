import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/stubs/kuick_authflow_stub.dart';
import '../../../../core/wrappers/theme_wrapper.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart' show AuthLoginEvent;

class AuthFlow extends StatelessWidget {
  final Widget? child;
  const AuthFlow({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, themeMode) {
        return BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: KuickAuthFlow(
            themeMode: themeMode,
            projectId: "",
            projectName: "",
            onAuthSuccess: (userData) async {
              context.read<AuthBloc>().add(AuthLoginEvent(userData));
            },
            child: child,
          ),
        );
      },
    );
  }
}
