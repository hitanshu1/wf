// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String hello_user(Object name) {
    return 'Hello $name';
  }

  @override
  String get project => 'Project';

  @override
  String get search => 'Search';

  @override
  String get debug => 'Debug';

  @override
  String get device => 'Device';

  @override
  String get projects => 'Projects';

  @override
  String get project_description =>
      'Track ongoing workstreams, review ticket progress, and jump into repositories.';

  @override
  String get active_projects => 'Active Projects';

  @override
  String get pending_reviews => 'Pending Reviews';

  @override
  String get deploy_ready => 'Deploy Ready';

  @override
  String get recent_activity => 'Recent Activity';

  @override
  String get merged_feature => 'Merged feature/payment-intent';

  @override
  String get qa_approved => 'QA approved onboarding wizard';

  @override
  String get scheduled_release => 'Scheduled release 2.3.0';

  @override
  String get search_workspace => 'Search Workspace';

  @override
  String get search_description =>
      'Find code, designs, or documents instantly with federated project search.';

  @override
  String get indexed_services => 'Indexed Services';

  @override
  String get saved_queries => 'Saved Queries';

  @override
  String get ai_smart_results => 'AI Smart Results';

  @override
  String get recent_searches => 'Recent Searches';

  @override
  String get error_boundary => 'error boundary implementation';

  @override
  String get dark_theme_tokens => 'dark theme tokens';

  @override
  String get deployment_checklist => 'deployment checklist';

  @override
  String get debug_console => 'Debug Console';

  @override
  String get debug_description =>
      'Inspect logs, track breakpoints, and monitor runtime diagnostics.';

  @override
  String get active_breakpoints => 'Active Breakpoints';

  @override
  String get warnings => 'Warnings';

  @override
  String get last_build => 'Last Build';

  @override
  String get latest_logs => 'Latest Logs';

  @override
  String get info_auth_service => '[INFO] Auth service initialized';

  @override
  String get warn_missing_locale => '[WARN] Missing locale strings detected';

  @override
  String get debug_experiment_flag =>
      '[DEBUG] Experiment flag enabled: checkout_redesign';

  @override
  String get connected_devices => 'Connected Devices';

  @override
  String get device_description =>
      'Manage simulator sessions, physical devices, and remote debugging targets.';

  @override
  String get online_devices => 'Online Devices';

  @override
  String get simulators => 'Simulators';

  @override
  String get remote_sessions => 'Remote Sessions';

  @override
  String get device_feed => 'Device Feed';

  @override
  String get pixel_hot_reload => 'Pixel 8 • Hot reload successful';

  @override
  String get iphone_screenshot => 'iPhone 15 • Screenshot captured';

  @override
  String get qa_tablet_crash => 'QA Tablet • Crash log uploaded';

  @override
  String get project_inspector => 'Project Inspector';

  @override
  String get status => 'Status';

  @override
  String get health => 'Health';

  @override
  String get stable => 'Stable';

  @override
  String get deploys_24h => 'Deploys (24h)';

  @override
  String get open_issues => 'Open Issues';

  @override
  String get quick_actions => 'Quick Actions';

  @override
  String get create_ticket => 'Create ticket';

  @override
  String get open_pipeline => 'Open pipeline';

  @override
  String get switch_branch => 'Switch branch';

  @override
  String get demo_code => 'Demo Code';

  @override
  String get notes => 'Notes';

  @override
  String get notes_description =>
      'Use this panel to surface project insights, CI status, or assign follow-up actions to collaborators.';

  @override
  String get code_snippet_description =>
      'Use this snippet to wire the new StepButton into your workflow actions.';
}
