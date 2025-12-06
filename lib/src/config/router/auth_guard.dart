import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Authentication guard for GoRouter.
/// Currently disabled - allows all routes without authentication.
String? authGuard(BuildContext _, GoRouterState state) {
  // Disabled authentication - allow all routes
  // Return null to allow navigation to proceed
  return null;
}
