import 'package:get_it/get_it.dart';
import '../../config/router/routes_config.dart';
import '../../core/navigation/kuick_navigation.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/dashboard/data/data_sources/dashboard_api_service.dart';
import '../../features/dashboard/data/data_sources/dashboard_local_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/auth/service/auth_service.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';
import '../storage/hive/hive_manager.dart';
import '../url_strategy/url_strategy_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _initCore();
  _initDashboardFeature();
}

/// ---------------------------------------------
/// CORE MODULE
/// ---------------------------------------------
Future<void> _initCore() async {
  // Url Strategy Service
  sl.registerLazySingleton<UrlStrategyService>(() => UrlStrategyService());
  sl<UrlStrategyService>().init();

  // Router & Navigation
  sl.registerLazySingleton<AppRouter>(() => AppRouter());
  sl.registerLazySingleton<KuickNavigation>(() => KuickNavigation());

  // Hive (Local Storage)
  sl.registerLazySingleton<HiveManager>(() => HiveManager());
  await sl<HiveManager>().init();

  // Networking
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<NetworkCalls>(
    () => NetworkCalls(dioClient: sl<DioClient>()),
  );
  sl.registerLazySingleton<AuthService>(() => const AuthService());
  sl.registerFactory<AuthBloc>(() => AuthBloc());
}

/// ---------------------------------------------
/// DASHBOARD FEATURE MODULE
/// ---------------------------------------------
void _initDashboardFeature() {
  // Data Sources
  sl.registerLazySingleton<DashboardApiService>(
    () => DashboardApiService(networkCalls: sl<NetworkCalls>()),
  );
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSource(),
  );

  // Repository (use interface)
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      apiService: sl<DashboardApiService>(),
      localDataSource: sl<DashboardLocalDataSource>(),
    ),
  );
}
