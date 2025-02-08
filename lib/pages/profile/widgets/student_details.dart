import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/pages/profile/helpers/classes/profile_item_data.dart';
import 'package:school_erp/pages/profile/widgets/profile_details_list.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class StudentDetails extends StatelessWidget{
    final Student student;
    final List<Guardian> guardians;

    const StudentDetails({
        super.key,
        required this.student, 
        required this.guardians
    });

    @override
    Widget build(BuildContext context) {
        final List<ProfileItemData> studentItemDataList = 
            [
                ProfileItemData('Student No.', student.studentNo, CupertinoIcons.lock_fill),
                ProfileItemData('Academic Year', '${student.academicYearStart} - ${student.academicYearEnd}', CupertinoIcons.lock_fill),
                ProfileItemData('Grade Level', student.gradeLevelName!.title(), CupertinoIcons.lock_fill),
                ProfileItemData('Section', student.sectionName!.title(), CupertinoIcons.lock_fill),
                ProfileItemData('Date of Birth', DateFormat('dd MMM, yyyy').format(student.birthDate!), CupertinoIcons.lock_fill),
                ProfileItemData('Permanent Address', student.address!.title(), CupertinoIcons.lock_fill, 370),
                ProfileItemData('Guardian Email', guardians[0].email!, CupertinoIcons.lock_fill, 370),
            ];

        for (int i = 0; i < guardians.length; i++) {
            studentItemDataList.add(
                ProfileItemData(
                    'Guardian ${i + 1}', 
                    guardians[i].displayName, 
                    CupertinoIcons.lock_fill, 
                    370
                )
            );
        }

        return ProfileDetailsList(items: studentItemDataList);
    }

}