import 'package:flutter/material.dart';
import 'package:school_erp/routes/routes.dart';
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
          path: '/default-page?title=Quiz',
        ),
        FeatureButton(
          title: 'Homework',
          icon: Icons.assignment,
          path: assignmentListRoute.path,
          visible: assignmentListRoute.allowedRoles!.contains(user.role),
        ),
        FeatureButton(
          title: 'Learn',
          icon: Icons.local_library_outlined,
          path: '/default-page?title=Learn',
          //target: LearnPage(),
        ),
        FeatureButton(
          title: 'Attendance',
          icon: Icons.emoji_people_outlined,
          path: attendanceCheckRoute.path,
          visible: attendanceCheckRoute.allowedRoles!.contains(user.role),
        ),
        FeatureButton(
          title: 'Billing',
          icon: Icons.payment_outlined,
          path: billingRoute.path,
          visible: billingRoute.allowedRoles!.contains(user.role),
        ),
      ]),
      FeatureSection(title: 'Time Calendar', features: <FeatureButton>[
        FeatureButton(
          title: '${user.role.displayName} Calendar',
          icon: Icons.calendar_month,
          path: attendanceCalendarRoute.path,
        ),
        const FeatureButton(
          title: 'Subject\nSchedule',
          icon: Icons.event_note,
          path: '/default-page?title=TimeTable',
          //target: TimeTablePage(),
        ),
        const FeatureButton(
          title: 'Apply Absents',
          icon: Icons.edit_calendar,
          path: '/default-page?title=LeaveApplication',
          //target: LeaveApplicationPage(),
        ),
      ]),
      const FeatureSection(title: 'Activities', features: <FeatureButton>[
        FeatureButton(
          title: 'Events',
          icon: Icons.celebration,
          path: '/default-page?title=Events',
          //target: EventsPage(),
        ),
        FeatureButton(
          title: 'School Gallery',
          icon: Icons.collections,
          path: '/default-page?title=SchoolGallery',
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
                    context.push(feature.path);
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
  final String path;
  final bool visible;

  const FeatureButton(
      {required this.title,
      required this.icon,
      required this.path,
      this.visible = true});
}
