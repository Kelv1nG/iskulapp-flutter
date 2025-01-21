import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/profile/formText.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/profile/widgets/profile_header.dart';

class FormTextData {
    final String label;
    final String value;
    final IconData? icon;
    final double width;

    FormTextData(this.label, this.value, [this.icon, this.width = 175]);
}

class MyIcons {
    static const IconData cameraAltOutlined =
        IconData(0xef1e, fontFamily: 'MaterialIcons');
}

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

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: 'My Profile',
            content: [
                AppContent(
                    content: [
                        ProfileHeader(user: user),
                        profileForm(),
                    ]),
            ],
        );
    }

    Widget profileForm() {
        final List<List<FormTextData>> formTextDataList = [
            [
                FormTextData('Adhar No.', '1234 4325 4567 1234'),
                FormTextData('Academic Year', '2020 - 2021'),
            ],
            [
                FormTextData('Admission Class', 'VI', CupertinoIcons.lock_fill),
                FormTextData('Old Admission No.', 'T00221', CupertinoIcons.lock_fill),
            ],
            [
                FormTextData(
                    'Date of Admission', '01 Apr 2018', CupertinoIcons.lock_fill),
                FormTextData('Date of Birth', '22 July 1996', CupertinoIcons.lock_fill),
            ],
            [
                FormTextData('Parent Mail ID', 'parentboth84@gmail.com',
                    CupertinoIcons.lock_fill, 370),
            ],
            [
                FormTextData(
                    'Mother Name', 'Monica Larson', CupertinoIcons.lock_fill, 370),
            ],
            [
                FormTextData(
                    'Father Nme', 'Bernard Taylor', CupertinoIcons.lock_fill, 370),
            ],
            [
                FormTextData('Permanent Add', 'Karol Bagh, Delhi',
                    CupertinoIcons.lock_fill, 370),
            ],
        ];

        return SingleChildScrollView(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: formTextDataList.length,
                itemBuilder: (context, index) {
                    return buildFormRow(formTextDataList[index]);
                },
            ),
        );
    }

    Widget buildFormRow(List<FormTextData> data) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: data.map((item) {
                    return Expanded(
                        child: FormText(
                            width: item.width,
                            height: 75,
                            label: item.label,
                            value: item.value,
                            icon: item.icon != null
                                ? Icon(item.icon, size: 22.0, color: Colors.grey)
                                : null,
                        ),
                    );
                }).toList(),
        );
    }
}
