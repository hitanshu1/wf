import 'package:equatable/equatable.dart';

class LocaleState extends Equatable {
  final String localeCode;

  const LocaleState({required this.localeCode});

  @override
  List<Object?> get props => [localeCode];
}
