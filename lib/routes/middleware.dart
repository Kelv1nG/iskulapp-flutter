import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_erp/enums/user_role.dart';
import 'package:school_erp/features/auth/utils.dart';

typedef Route = String;
typedef RouteMiddleware = Future<Route?> Function(
    BuildContext context, GoRouterState state);

RouteMiddleware roleMiddleware(List<UserRole> accessibleRoles) {
  return (context, state) async {
    final user = getAuthUser(context);

    if (!accessibleRoles.contains(user.role)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Access Denied for ${user.role.displayName}')),
      );
      final extra = state.extra as Map<String, dynamic>?;
      final previousRoute = extra?['from'] as String? ?? '/';
      return previousRoute;
    }
    return null;
  };
}
