// Stub file for kuick_authflow package
// This file provides temporary implementations until the actual package is available

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Model classes
class LoginUserDetails {
  final int? userId;
  final String? userEmail;
  final String? userName;

  LoginUserDetails({
    this.userId,
    this.userEmail,
    this.userName,
  });
}

class LoginData {
  final String? token;
  final String? newToken;
  final LoginUserDetails? userDetails;

  LoginData({
    this.token,
    this.newToken,
    this.userDetails,
  });
}

class LoginModel {
  final String? status;
  final String? redirect;
  final int? redirectId;
  final String? msg;
  final LoginData? data;

  LoginModel({
    this.status,
    this.redirect,
    this.redirectId,
    this.msg,
    this.data,
  });
}

// Routes
class KuickAuthRoutes {
  static const signIn = _AuthRoute('/sign-in');
  static const signUp = _AuthRoute('/sign-up');
  static const forgotPassword = _AuthRoute('/forgot-password');
  static const otp = _AuthRoute('/otp');
  static const changePassword = _AuthRoute('/change-password');
}

class _AuthRoute {
  final String path;
  const _AuthRoute(this.path);
}

// Auth Router
class AuthRouter {
  static List<RouteBase> get authRoutes => [
    GoRoute(
      path: KuickAuthRoutes.signIn.path,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Sign In (Stub)')),
      ),
    ),
    GoRoute(
      path: KuickAuthRoutes.signUp.path,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Sign Up (Stub)')),
      ),
    ),
    GoRoute(
      path: KuickAuthRoutes.forgotPassword.path,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Forgot Password (Stub)')),
      ),
    ),
    GoRoute(
      path: KuickAuthRoutes.otp.path,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('OTP (Stub)')),
      ),
    ),
    GoRoute(
      path: KuickAuthRoutes.changePassword.path,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Change Password (Stub)')),
      ),
    ),
  ];
}

// Auth Flow Widget
class KuickAuthFlow extends StatelessWidget {
  final ThemeMode? themeMode;
  final String projectId;
  final String projectName;
  final Function(dynamic)? onAuthSuccess;
  final Widget? child;

  const KuickAuthFlow({
    super.key,
    this.themeMode,
    required this.projectId,
    required this.projectName,
    this.onAuthSuccess,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child ?? const Scaffold(
      body: Center(child: Text('Auth Flow (Stub)')),
    );
  }
}






