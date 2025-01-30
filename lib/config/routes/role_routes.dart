import 'package:school_erp/enums/user_role.dart';

class RoleRoutes {
  static final Map<UserRole, List<String>> accessMap = {
    UserRole.teacher: [
      '/attendance-check',
      '/attendance-calendar',
      '/default-page',
    ],
    UserRole.student: [
      '/attendance-calendar',
      '/default-page',
    ],
    UserRole.parent: [],
  };

  static bool canAccess(UserRole role, String route) {
    final uri = Uri.parse(route);
    final path = uri.path;
    return accessMap[role]?.contains(path) ?? false;
  }
}
