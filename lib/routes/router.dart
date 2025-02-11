import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_question_setup/assessment_question_setup_page.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/assessment_setup_page.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/assessment_takers_page.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/assignment_list_page.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/attendance/attendance_create_update/attendance_create_update_page.dart';
import 'package:school_erp/pages/default_page.dart';
import 'package:school_erp/pages/home/home_page.dart';
import 'package:school_erp/pages/login/login_page.dart';
import 'package:school_erp/routes/middleware.dart';
import 'package:school_erp/routes/middleware_route.dart';
import 'package:school_erp/routes/routes.dart';

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
      path: loginRoute.path,
      builder: (context, state) => const LoginPage(),
    ),
    middlewareRoute(
      name: attendanceCheckRoute.name,
      path: attendanceCheckRoute.path,
      pageBuilder: (context, state) => createSlideRoutePage(
        AttendanceCreateUpdatePage(),
      ),
      middleware: [
        roleMiddleware(attendanceCheckRoute.allowedRoles!),
      ],
    ),
    GoRoute(
      name: attendanceCalendarRoute.name,
      path: attendanceCalendarRoute.path,
      pageBuilder: (context, state) => createSlideRoutePage(
        AttendanceCalendarPage(),
      ),
    ),
    middlewareRoute(
      name: assignmentListRoute.name,
      path: assignmentListRoute.path,
      pageBuilder: (context, state) => createSlideRoutePage(
        AssignmentListPage(),
      ),
      middleware: [
        roleMiddleware(assignmentListRoute.allowedRoles!),
      ],
    ),
    middlewareRoute(
      name: assessmentSetupRoute.name,
      path: assessmentSetupRoute.path,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final assessment = extra['assessment'] as Assessment?;
        final assessmentTypeOnCreate =
            extra['assessmentTypeOnCreate'] as AssessmentType?;

        if (assessment != null) {
          return createSlideRoutePage(
              AssessmentSetupPage(assessment: assessment));
        }
        return createSlideRoutePage(AssessmentSetupPage(
            assessmentTypeOnCreate: assessmentTypeOnCreate));
      },
      middleware: [
        roleMiddleware(assessmentSetupRoute.allowedRoles!),
      ],
    ),
    middlewareRoute(
      name: assessmentTakersRoute.name,
      path: assessmentTakersRoute.path,
      pageBuilder: (context, state) {
        final assessmentCubit = state.extra as AssessmentCubit;

        return createSlideRoutePage(
          BlocProvider.value(
            value: assessmentCubit,
            child: const AssessmentTakersPage(),
          ),
        );
      },
    ),
    middlewareRoute(
      name: assessmentQuestionSetupRoute.name,
      path: assessmentQuestionSetupRoute.path,
      pageBuilder: (context, state) {
        final assessmentCubit = state.extra as AssessmentCubit;

        return createSlideRoutePage(
          BlocProvider.value(
            value: assessmentCubit,
            child: const AssessmentQuestionSetupPage(),
          ),
        );
      },
      middleware: [roleMiddleware(assessmentQuestionSetupRoute.allowedRoles!)],
    ),
    middlewareRoute(
      name: billingRoute.name,
      path: billingRoute.path,
      pageBuilder: (context, state) {
        return createSlideRoutePage(
          DefaultPage(title: 'Billing'),
        );
      },
      middleware: [roleMiddleware(billingRoute.allowedRoles!)],
    ),
    GoRoute(
      name: defaultPageRoute.name,
      path: defaultPageRoute.path,
      pageBuilder: (context, state) {
        final String title =
            state.uri.queryParameters['title'] ?? 'Default page';
        return createSlideRoutePage(DefaultPage(title: title));
      },
    ),
  ],
);
