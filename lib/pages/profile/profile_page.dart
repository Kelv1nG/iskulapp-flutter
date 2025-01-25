import 'package:flutter/cupertino.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/profile/helpers/classes/profile_item_data.dart';
import 'package:school_erp/pages/profile/widgets/profile_details_list.dart';
import 'package:school_erp/pages/profile/widgets/profile_header.dart';

class ProfilePage extends StatefulWidget {
    const ProfilePage({super.key});

    @override
    createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    late final AuthenticatedUser user;

    @override
    void initState() {
        super.initState();

        _getUserDetails();
    }

    void _getUserDetails() {
        AuthenticatedUser authUser = getAuthUser(context);
        setState(() => user = authUser);
    }

    // TEMPORARY - NO DATA HERE YET
    final List<ProfileItemData> profileItemDataList = [
        ProfileItemData('Adhar No.', '1234 4325 4567 1234'),
        ProfileItemData('Academic Year', '2020 - 2021'),
        ProfileItemData('Grade Level', 'VI', CupertinoIcons.lock_fill),
        ProfileItemData('Section', 'T00221', CupertinoIcons.lock_fill),
        ProfileItemData('Date of Admission', '01 Apr 2018', CupertinoIcons.lock_fill),
        ProfileItemData('Date of Birth', '22 July 1996', CupertinoIcons.lock_fill),
        ProfileItemData('Parent Email', 'parentboth84@gmail.com', CupertinoIcons.lock_fill, 370),
        ProfileItemData('Mother Name', 'Monica Larson', CupertinoIcons.lock_fill, 370),
        ProfileItemData('Father Name', 'Bernard Taylor', CupertinoIcons.lock_fill, 370),
        ProfileItemData('Permanent Address', 'Karol Bagh, Delhi', CupertinoIcons.lock_fill, 370),
    ];

    @override
    Widget build(BuildContext context) {
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
