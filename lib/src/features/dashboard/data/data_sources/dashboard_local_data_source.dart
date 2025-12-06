import '../models/dashboard_model.dart';

class DashboardLocalDataSource {
  DashboardModel? _cache;

  DashboardModel? getData() => _cache;
  void saveData(DashboardModel data) => _cache = data;
}
