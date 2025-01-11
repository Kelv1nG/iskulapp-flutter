enum UserRole {
    student("student", "Student"),
    teacher("teacher", "Teacher"),
    parent("parent", "Parent");

    final String value;
    final String displayName;

    const UserRole(this.value, this.displayName);

    static UserRole fromString(String value) {
        return values.firstWhere(
            (v) => v.value == value,
            orElse: () =>
            throw ArgumentError('Invalid UserRole value: $value'),
        );
    }

    static UserRole fromDisplayName(String displayName) {
        return values.firstWhere(
            (v) => v.displayName.toLowerCase() == displayName.toLowerCase(),
            orElse: () => throw ArgumentError(
                'Invalid UserRole display name: $displayName'),
        );
    }
}

