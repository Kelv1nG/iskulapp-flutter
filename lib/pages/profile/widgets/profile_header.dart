import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/theme/colors.dart';

class ProfileHeader extends StatelessWidget{
    final AuthenticatedUser user;

    const ProfileHeader({
        super.key, 
        required this.user
    });

    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                            width: 75,
                            height: 75,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                            ),
                        ),
                    ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            '${user.lastName.toUpperCase()}, ${user.firstName}',
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                            ),
                        ),
                        Text(
                            'Class XI-B | Roll no: 04',
                            style: TextStyle(
                                color: AppColors.secondaryFontColor,
                                fontSize: 14,
                            ),
                        ),
                    ],
                )
            ],

        );
    }


}