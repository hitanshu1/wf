import 'package:flutter/material.dart';
import 'package:kuick_workflow/src/features/auth/presentation/view/auth_view.dart';
import 'config/localization/generated/app_localizations.dart';
import 'config/router/routes_config.dart';
import 'config/theme/app_theme.dart';
import 'core/di/service_locator.dart';
import 'core/utils/defer_pointor/defer_pointer.dart';
import 'core/wrappers/bloc_provider_wrapper.dart';
import 'core/wrappers/locale_wrapper.dart';
import 'core/wrappers/theme_wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: BlocProviderWrapper(
        child: ThemeWrapper(
          builder: (_, themeMode) {
            return LocaleWrapper(
              builder: (_, locale) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: locale,
                  title: 'Kuick Boilerplate',
                  routerConfig: sl<AppRouter>().router,
                  themeMode: themeMode,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  builder: (context, child) {
                    return AuthFlow(child: child);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
