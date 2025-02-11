import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarAddButton extends StatelessWidget {
  final String path;
  // extra arguments in that can be supplied in route
  final Map<String, dynamic>? extra;

  const AppBarAddButton({super.key, required this.path, this.extra});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(path, extra: extra),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.lightGreen[400],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
