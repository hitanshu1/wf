import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @hello_user.
  ///
  /// In en, this message translates to:
  /// **'Hello {name}'**
  String hello_user(Object name);

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @debug.
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get debug;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get device;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @project_description.
  ///
  /// In en, this message translates to:
  /// **'Track ongoing workstreams, review ticket progress, and jump into repositories.'**
  String get project_description;

  /// No description provided for @active_projects.
  ///
  /// In en, this message translates to:
  /// **'Active Projects'**
  String get active_projects;

  /// No description provided for @pending_reviews.
  ///
  /// In en, this message translates to:
  /// **'Pending Reviews'**
  String get pending_reviews;

  /// No description provided for @deploy_ready.
  ///
  /// In en, this message translates to:
  /// **'Deploy Ready'**
  String get deploy_ready;

  /// No description provided for @recent_activity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recent_activity;

  /// No description provided for @merged_feature.
  ///
  /// In en, this message translates to:
  /// **'Merged feature/payment-intent'**
  String get merged_feature;

  /// No description provided for @qa_approved.
  ///
  /// In en, this message translates to:
  /// **'QA approved onboarding wizard'**
  String get qa_approved;

  /// No description provided for @scheduled_release.
  ///
  /// In en, this message translates to:
  /// **'Scheduled release 2.3.0'**
  String get scheduled_release;

  /// No description provided for @search_workspace.
  ///
  /// In en, this message translates to:
  /// **'Search Workspace'**
  String get search_workspace;

  /// No description provided for @search_description.
  ///
  /// In en, this message translates to:
  /// **'Find code, designs, or documents instantly with federated project search.'**
  String get search_description;

  /// No description provided for @indexed_services.
  ///
  /// In en, this message translates to:
  /// **'Indexed Services'**
  String get indexed_services;

  /// No description provided for @saved_queries.
  ///
  /// In en, this message translates to:
  /// **'Saved Queries'**
  String get saved_queries;

  /// No description provided for @ai_smart_results.
  ///
  /// In en, this message translates to:
  /// **'AI Smart Results'**
  String get ai_smart_results;

  /// No description provided for @recent_searches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get recent_searches;

  /// No description provided for @error_boundary.
  ///
  /// In en, this message translates to:
  /// **'error boundary implementation'**
  String get error_boundary;

  /// No description provided for @dark_theme_tokens.
  ///
  /// In en, this message translates to:
  /// **'dark theme tokens'**
  String get dark_theme_tokens;

  /// No description provided for @deployment_checklist.
  ///
  /// In en, this message translates to:
  /// **'deployment checklist'**
  String get deployment_checklist;

  /// No description provided for @debug_console.
  ///
  /// In en, this message translates to:
  /// **'Debug Console'**
  String get debug_console;

  /// No description provided for @debug_description.
  ///
  /// In en, this message translates to:
  /// **'Inspect logs, track breakpoints, and monitor runtime diagnostics.'**
  String get debug_description;

  /// No description provided for @active_breakpoints.
  ///
  /// In en, this message translates to:
  /// **'Active Breakpoints'**
  String get active_breakpoints;

  /// No description provided for @warnings.
  ///
  /// In en, this message translates to:
  /// **'Warnings'**
  String get warnings;

  /// No description provided for @last_build.
  ///
  /// In en, this message translates to:
  /// **'Last Build'**
  String get last_build;

  /// No description provided for @latest_logs.
  ///
  /// In en, this message translates to:
  /// **'Latest Logs'**
  String get latest_logs;

  /// No description provided for @info_auth_service.
  ///
  /// In en, this message translates to:
  /// **'[INFO] Auth service initialized'**
  String get info_auth_service;

  /// No description provided for @warn_missing_locale.
  ///
  /// In en, this message translates to:
  /// **'[WARN] Missing locale strings detected'**
  String get warn_missing_locale;

  /// No description provided for @debug_experiment_flag.
  ///
  /// In en, this message translates to:
  /// **'[DEBUG] Experiment flag enabled: checkout_redesign'**
  String get debug_experiment_flag;

  /// No description provided for @connected_devices.
  ///
  /// In en, this message translates to:
  /// **'Connected Devices'**
  String get connected_devices;

  /// No description provided for @device_description.
  ///
  /// In en, this message translates to:
  /// **'Manage simulator sessions, physical devices, and remote debugging targets.'**
  String get device_description;

  /// No description provided for @online_devices.
  ///
  /// In en, this message translates to:
  /// **'Online Devices'**
  String get online_devices;

  /// No description provided for @simulators.
  ///
  /// In en, this message translates to:
  /// **'Simulators'**
  String get simulators;

  /// No description provided for @remote_sessions.
  ///
  /// In en, this message translates to:
  /// **'Remote Sessions'**
  String get remote_sessions;

  /// No description provided for @device_feed.
  ///
  /// In en, this message translates to:
  /// **'Device Feed'**
  String get device_feed;

  /// No description provided for @pixel_hot_reload.
  ///
  /// In en, this message translates to:
  /// **'Pixel 8 • Hot reload successful'**
  String get pixel_hot_reload;

  /// No description provided for @iphone_screenshot.
  ///
  /// In en, this message translates to:
  /// **'iPhone 15 • Screenshot captured'**
  String get iphone_screenshot;

  /// No description provided for @qa_tablet_crash.
  ///
  /// In en, this message translates to:
  /// **'QA Tablet • Crash log uploaded'**
  String get qa_tablet_crash;

  /// No description provided for @project_inspector.
  ///
  /// In en, this message translates to:
  /// **'Project Inspector'**
  String get project_inspector;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @stable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get stable;

  /// No description provided for @deploys_24h.
  ///
  /// In en, this message translates to:
  /// **'Deploys (24h)'**
  String get deploys_24h;

  /// No description provided for @open_issues.
  ///
  /// In en, this message translates to:
  /// **'Open Issues'**
  String get open_issues;

  /// No description provided for @quick_actions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quick_actions;

  /// No description provided for @create_ticket.
  ///
  /// In en, this message translates to:
  /// **'Create ticket'**
  String get create_ticket;

  /// No description provided for @open_pipeline.
  ///
  /// In en, this message translates to:
  /// **'Open pipeline'**
  String get open_pipeline;

  /// No description provided for @switch_branch.
  ///
  /// In en, this message translates to:
  /// **'Switch branch'**
  String get switch_branch;

  /// No description provided for @demo_code.
  ///
  /// In en, this message translates to:
  /// **'Demo Code'**
  String get demo_code;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notes_description.
  ///
  /// In en, this message translates to:
  /// **'Use this panel to surface project insights, CI status, or assign follow-up actions to collaborators.'**
  String get notes_description;

  /// No description provided for @code_snippet_description.
  ///
  /// In en, this message translates to:
  /// **'Use this snippet to wire the new StepButton into your workflow actions.'**
  String get code_snippet_description;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
