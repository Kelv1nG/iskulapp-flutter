extension StringExtension on String {
    String capitalize() {
        return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }

    String title() {
        return split(RegExp(r'[_\s]')).map((word) => word.capitalize()).join(' ');
    }
}
