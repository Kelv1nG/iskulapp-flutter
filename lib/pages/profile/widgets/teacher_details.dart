import 'package:flutter/cupertino.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/pages/profile/helpers/classes/profile_item_data.dart';
import 'package:school_erp/pages/profile/widgets/profile_details_list.dart';

class TeacherDetails extends StatelessWidget{
    final AuthenticatedUser user;
    final Teacher teacher;

    const TeacherDetails({
        super.key, 
        required this.user,
        required this.teacher
    });

    @override
    Widget build(BuildContext context) {
        final List<ProfileItemData> teacherItemDataList = 
            [
                ProfileItemData('Teacher No.', teacher.teacherNo, CupertinoIcons.lock_fill),
                ProfileItemData('Email', user.email, CupertinoIcons.lock_fill),
            ];

        return ProfileDetailsList(items: teacherItemDataList);
    }
}