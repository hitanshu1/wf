import 'package:flutter/material.dart';

import '../../../config/localization/generated/app_localizations.dart';

extension LocalizationExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
