import 'package:hive/hive.dart';
import 'login_data_adepter.dart';

class HiveAdapters {
  static void registerAll() {
    // Register LoginUserDetailsAdapter
    if (!Hive.isAdapterRegistered(LoginUserDetailsAdapter().typeId)) {
      Hive.registerAdapter(LoginUserDetailsAdapter());
    }

    // Register LoginDataAdapter
    if (!Hive.isAdapterRegistered(LoginDataAdapter().typeId)) {
      Hive.registerAdapter(LoginDataAdapter());
    }

    // Register LoginModelAdapter
    if (!Hive.isAdapterRegistered(LoginModelAdapter().typeId)) {
      Hive.registerAdapter(LoginModelAdapter());
    }
  }
}
