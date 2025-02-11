import 'package:flutter/material.dart';
import 'package:school_erp/pages/home/bottom_nav/bottom_nav_destinations.dart';

class BottomNavigation extends StatelessWidget {
  final BottomNavDestinations destinations;
  final int currentPageIndex;
  final void Function(int) tapFn;

  const BottomNavigation({
    super.key,
    required this.tapFn,
    required this.destinations,
    required this.currentPageIndex,
  });

  void onTap(int index) {
    tapFn(index);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        height: 60,
        onDestinationSelected: onTap,
        selectedIndex: currentPageIndex,
        destinations: destinations.navs.map((destination) {
          return NavigationDestination(
            selectedIcon: destination.selectedIcon,
            icon: destination.icon,
            label: destination.label,
          );
        }).toList());
  }
}
