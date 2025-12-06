import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/locale_service.dart';
import 'locale_event.dart';
import 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(localeCode: 'en')) {
    on<LoadLocale>((event, emit) async {
      final saved = await LocaleService.getLocaleCode();
      emit(LocaleState(localeCode: saved));
    });

    on<ChangeLocale>((event, emit) async {
      emit(LocaleState(localeCode: event.localeCode));
      await LocaleService.saveLocaleCode(event.localeCode);
    });
  }
}
