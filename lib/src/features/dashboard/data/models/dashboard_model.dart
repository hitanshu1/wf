import 'package:flutter/material.dart';

import '../../../../config/router/routes.dart';
import '../../domain/entities/dashboard_data.dart';

class DashboardModel extends DashboardData {
  DashboardModel({required super.title, required super.count});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      title: json['title'] ?? '',
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'count': count};
}

/// Model class for sidebar route item
class DashboardRouteItem {
  final KuickPath route;
  final String label;
  final IconData icon;

  const DashboardRouteItem({
    required this.route,
    required this.label,
    required this.icon,
  });
}
