import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/attendance/attendance_create_update/attendance_create_update_page.dart';
import 'package:school_erp/pages/default_page.dart';
import 'package:school_erp/pages/home/home_page.dart';
import 'package:school_erp/pages/login/login_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) {
    try {
      final authState = context.watch<AuthBloc>().state;
      return authState.when(
        initial: () => null,
        loading: () => null,
        authenticated: (user, token) {
          if (state.uri.path == '/login') {
            return '/';
          }
          return null;
        },
        unauthenticated: () {
          if (state.uri.path != '/login') {
            return '/login';
          }
          return null;
        },
        failure: (statusCode, message) => null,
      );
    } catch (e) {
      // if cant access auth bloc dont redirect
      return null;
    }
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        try {
          final authState = context.watch<AuthBloc>().state;
          return authState.maybeWhen(
            authenticated: (user, token) => HomePage(user),
            orElse: () => const LoginPage(),
          );
        } catch (e) {
          return const LoginPage();
        }
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'attendance-check',
      path: '/attendance-check',
      pageBuilder: (context, state) => createSlideRoutePage(
        AttendanceCreateUpdatePage(),
      ),
    ),
    GoRoute(
      name: 'attendance-calendar',
      path: '/attendance-calendar',
      pageBuilder: (context, state) => createSlideRoutePage(
        AttendanceCalendarPage(),
      ),
    ),
    GoRoute(
      name: 'default-page',
      path: '/default-page',
      pageBuilder: (context, state) {
        final String title =
            state.uri.queryParameters['title'] ?? 'Default page';
        return createSlideRoutePage(DefaultPage(title: title));
      },
    ),
  ],
);
