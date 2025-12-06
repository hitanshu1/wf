import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../localization/bloc/locale_bloc.dart';
import '../localization/bloc/locale_event.dart';
import '../localization/bloc/locale_state.dart';

typedef LocaleBuilder = Widget Function(BuildContext context, Locale locale);

class LocaleWrapper extends StatelessWidget {
  final LocaleBuilder builder;

  const LocaleWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocaleBloc()..add(LoadLocale()),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          final locale = Locale(state.localeCode);
          return builder(context, locale);
        },
      ),
    );
  }
}
