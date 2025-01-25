import 'package:flutter/cupertino.dart';
import 'package:school_erp/enums/user_role.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/profile/helpers/classes/profile_item_data.dart';
import 'package:school_erp/pages/profile/widgets/profile_details_list.dart';
import 'package:school_erp/pages/profile/widgets/profile_header.dart';
import 'package:school_erp/repositories/sections_repository.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class ProfilePage extends StatefulWidget {
    const ProfilePage({super.key});

    @override
    createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    late final AuthenticatedUser user;
    late final Section section;

    @override
    void initState() {
        super.initState();

        _getUserDetails();
        if (user.role == UserRole.student) _getStudentProfileDetails();
    }

    void _getUserDetails() {
        AuthenticatedUser authUser = getAuthUser(context);
        setState(() => user = authUser);
    }

    void _getStudentProfileDetails() async {
        SectionRepository sectionRepository = SectionRepository();
        List<Section> sectionOfStudent = await sectionRepository.getSectionOfStudent(userId: user.id);

        // Get first row here instead of doing it in getSectionOfStudent.
        // getSectionOfStudent may also be modified to query for past sections of student
        setState(() => section = sectionOfStudent[0]);
    }

    @override
    Widget build(BuildContext context) {
        final List<ProfileItemData> profileItemDataList = [
            ProfileItemData('Adhar No.', '1234 4325 4567 1234'),
            ProfileItemData('Academic Year', '2020 - 2021'),
            ProfileItemData('Grade Level', section.gradeLevelName.capitalize(), CupertinoIcons.lock_fill),
            ProfileItemData('Section', section.displayName, CupertinoIcons.lock_fill),
            ProfileItemData('Date of Admission', '01 Apr 2018', CupertinoIcons.lock_fill),
            ProfileItemData('Date of Birth', '22 July 1996', CupertinoIcons.lock_fill),
            ProfileItemData('Parent Email', 'parentboth84@gmail.com', CupertinoIcons.lock_fill, 370),
            ProfileItemData('Mother Name', 'Monica Larson', CupertinoIcons.lock_fill, 370),
            ProfileItemData('Father Name', 'Bernard Taylor', CupertinoIcons.lock_fill, 370),
            ProfileItemData('Permanent Address', 'Karol Bagh, Delhi', CupertinoIcons.lock_fill, 370),
        ];

        return DefaultLayout(
            title: 'My Profile',
            content: [
                Expanded(
                    flex: 2,
                    child: ProfileHeader(user: user)
                ),
                Expanded(
                    flex: 8,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10), 
                        child: ProfileDetailsList(items: profileItemDataList)
                    )
                ),
            ],
        );
    }
}
