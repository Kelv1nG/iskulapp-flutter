import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;
  final Widget? trailingWidget;
  final Animation<double>? fadeAnimation;
  final TextStyle? titleStyle; // New parameter for title style
  final double height; // New parameter for height

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
    this.trailingWidget,
    this.fadeAnimation,
    this.titleStyle,
    this.height = 100, // Default height
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: AppBar(
        leading: FadeTransition(
          opacity: fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: onBackPressed,
          ),
        ),
        title: FadeTransition(
          opacity: fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
          child: Text(
            title,
            style: titleStyle ??
                const TextStyle(color: Colors.white, fontSize: 24.0),
          ),
        ),
        actions: [
          if (trailingWidget != null)
            FadeTransition(
              opacity: fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: trailingWidget!,
              ),
            ),
        ],
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}