import '../../../../config/router/routes.dart';
import '../../domain/entities/home_data.dart';

class HomeModel extends HomeData {
  HomeModel({required super.title, required super.count});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      title: json['title'] ?? '',
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'count': count};
}

/// Model class for sidebar route item
class HomeRouteItem {
  final KuickPath route;
  final String icon;

  const HomeRouteItem({
    required this.route,
    required this.icon,
  });
}
