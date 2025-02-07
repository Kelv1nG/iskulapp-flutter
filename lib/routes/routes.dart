import 'package:school_erp/enums/user_role.dart';

class RouteDetail {
  final String name;
  final String path;
  final List<UserRole>? allowedRoles;

  const RouteDetail({
    required this.name,
    required this.path,
    this.allowedRoles,
  });
}

// routes
final loginRoute = RouteDetail(name: 'login', path: '/login');

final attendanceCheckRoute = RouteDetail(
  name: 'attendance-check',
  path: '/attendance-check',
  allowedRoles: [UserRole.teacher],
);

final attendanceCalendarRoute = RouteDetail(
  name: 'attendance-calendar',
  path: '/attendance-calendar',
);

final assignmentListRoute = RouteDetail(
  name: 'assignment-list',
  path: '/assignment-list',
  allowedRoles: [UserRole.teacher, UserRole.student],
);

final billingRoute = RouteDetail(
    name: 'billing', path: '/billing', allowedRoles: [UserRole.parent]);

final defaultPageRoute = RouteDetail(
  name: 'default-page',
  path: '/default-page',
);
