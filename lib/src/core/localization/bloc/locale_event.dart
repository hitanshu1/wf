import 'package:equatable/equatable.dart';

abstract class LocaleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadLocale extends LocaleEvent {}

class ChangeLocale extends LocaleEvent {
  final String localeCode;

  ChangeLocale(this.localeCode);

  @override
  List<Object?> get props => [localeCode];
}
