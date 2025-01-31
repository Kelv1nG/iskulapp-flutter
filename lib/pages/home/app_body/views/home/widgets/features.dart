import 'package:flutter/material.dart';
import 'package:school_erp/enums/user_role.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:go_router/go_router.dart';

class Features extends StatelessWidget {
  final AuthenticatedUser user;

  const Features({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    List<FeatureSection> features = [
      FeatureSection(title: 'Core', features: <FeatureButton>[
        FeatureButton(
          title: 'Quiz',
          icon: Icons.edit_note_outlined,
          route: '/default-page?title=Quiz',
        ),
        FeatureButton(
          title: 'Homework',
          icon: Icons.assignment,
          route: '/default-page?title=Assignment',
          //target: AssignmentListPage(),
        ),
        FeatureButton(
          title: 'Learn',
          icon: Icons.local_library_outlined,
          route: '/default-page?title=Learn',
          //target: LearnPage(),
        ),
        FeatureButton(
          title: 'Attendance',
          icon: Icons.emoji_people_outlined,
          route: '/attendance-check',
          visible: UserRole.teacher == user.role,
        ),
        FeatureButton(
          title: 'Billing',
          icon: Icons.payment_outlined,
          route: '/billing',
          visible: UserRole.parent == user.role,
        ),
      ]),
      FeatureSection(title: 'Time Calendar', features: <FeatureButton>[
        FeatureButton(
          title: '${user.role.displayName} Calendar',
          icon: Icons.calendar_month,
          route: '/attendance-calendar',
        ),
        const FeatureButton(
          title: 'Subject\nSchedule',
          icon: Icons.event_note,
          route: '/default-page?title=TimeTable',
          //target: TimeTablePage(),
        ),
        const FeatureButton(
          title: 'Apply Absents',
          icon: Icons.edit_calendar,
          route: '/default-page?title=LeaveApplication',
          //target: LeaveApplicationPage(),
        ),
      ]),
      const FeatureSection(title: 'Activities', features: <FeatureButton>[
        FeatureButton(
          title: 'Events',
          icon: Icons.celebration,
          route: '/default-page?title=Events',
          //target: EventsPage(),
        ),
        FeatureButton(
          title: 'School Gallery',
          icon: Icons.collections,
          route: '/default-page?title=SchoolGallery',
        ),
        //target: SchoolGalleryPage(),
      ]),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
            children: features.map((feature) {
          return _featuresContainer(context, feature);
        }).toList());
      },
    );
  }

  Widget _featuresContainer(BuildContext context, FeatureSection feature) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: (24)),
          child: Text(
            feature.title,
            style: headingStyle().copyWith(
              fontSize: 20,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: (14)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: feature.features.where((f) => f.visible).map((feature) {
                return GestureDetector(
                  onTap: () {
                    context.push(feature.route);
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.whiteColor,
                        child: Icon(
                          feature.icon,
                          size: 30,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        width: 78,
                        height: 50,
                        child: Text(
                          feature.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class FeatureSection {
  final String title;
  final List<FeatureButton> features;

  const FeatureSection({required this.title, required this.features});
}

class FeatureButton {
  final String title;
  final IconData icon;
  final String route;
  final bool visible;

  const FeatureButton(
      {required this.title,
      required this.icon,
      required this.route,
      this.visible = true});
}
