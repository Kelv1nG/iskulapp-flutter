import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_erp/routes/middleware.dart';

GoRoute middlewareRoute({
  required String name,
  required String path,
  required Page<dynamic> Function(BuildContext, GoRouterState) pageBuilder,
  List<RouteMiddleware> middleware =
      const [], // ordering matters because this is tied to redirect
}) {
  return GoRoute(
    name: name,
    path: path,
    redirect: (context, state) async {
      for (final middlewareFunc in middleware) {
        final route = await middlewareFunc(context, state);
        if (route != null) {
          return route;
        }
      }
      return null;
    },
    pageBuilder: pageBuilder,
  );
}
