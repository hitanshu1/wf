import '../../../core/navigation/kuick_navigation.dart';
import '../../../core/storage/hive/hive_boxes.dart';
import '../../../core/storage/storage_keys.dart';
import '../../../core/stubs/kuick_authflow_stub.dart';
import '../../../core/utils/app_logs.dart';

class AuthService {
  const AuthService();

  /// Returns whether a user is currently authenticated
  bool get isAuthenticated {
    final user = getUser();
    return user?.data?.token != null && user!.data!.token!.isNotEmpty;
  }

  /// Save authenticated user
  Future<void> setUser(LoginModel user) async {
    final box = HiveBoxes.userBox;
    await box.put(StorageKeys.currentUser, user);
    Log.i("User saved: ${user.data?.userDetails?.userEmail}");
  }

  /// Get current authenticated user (null if none)
  LoginModel? getUser() {
    final box = HiveBoxes.userBox;
    final user = box.get(StorageKeys.currentUser) as LoginModel?;
    return user;
  }

  /// Clear the current auth session (logout)
  Future<void> clearUser() async {
    final box = HiveBoxes.userBox;
    await box.delete(StorageKeys.currentUser);
    Log.i("User cleared (logged out)");
  }

  Future<void> logout() async {
    final box = HiveBoxes.userBox;
    await box.delete(StorageKeys.currentUser);
    KuickNavigation.goPath(KuickAuthRoutes.signIn.path);
    Log.i("User cleared (logged out)");
  }

  /// Return current token (useful for interceptors)
  String? get token {
    return getUser()?.data?.token;
  }
}
