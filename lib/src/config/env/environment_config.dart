import 'kuick_env.dart';

enum Environment { dev, staging, prod }

class EnvironmentConfig {
  static Environment get environment {
    final env = kuickEnv.env['ENV'] ?? 'dev';
    switch (env) {
      case 'prod':
        return Environment.prod;
      case 'staging':
        return Environment.staging;
      default:
        return Environment.dev;
    }
  }

  static String get apiBaseUrl =>
      kuickEnv.env['API_BASE_URL'] ?? 'https://api-dev.example.com';

  static String get appName => kuickEnv.env['APP_NAME'] ?? 'MyApp';

  static bool get enableAnalytics => kuickEnv.env['ENABLE_ANALYTICS'] == 'true';

  static bool get enableCrashlytics =>
      kuickEnv.env['ENABLE_CRASHLYTICS'] == 'true';

  static bool get isProd => environment == Environment.prod;
  static bool get isStaging => environment == Environment.staging;
  static bool get isDev => environment == Environment.dev;
}
