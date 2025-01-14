import 'package:json_annotation/json_annotation.dart';
import 'package:school_erp/enums/user_role.dart';

class UserRoleConverter implements JsonConverter<UserRole, String> {
    const UserRoleConverter();

    @override
    UserRole fromJson(String json) {
        return UserRole.fromString(json);
    }

    @override
    String toJson(UserRole object) {
        return object.value;
    }
}
