import 'package:flutter/material.dart';
import 'package:school_erp/pages/profile/formText.dart';
import 'package:school_erp/pages/profile/helpers/classes/profile_item_data.dart';
import 'package:school_erp/theme/colors.dart';

class ProfileDetailsCard extends StatelessWidget{
    final ProfileItemData item;

    const ProfileDetailsCard({super.key, required this.item});

    @override
    Widget build(Object context) {
        return FormText(
            width: item.width,
            height: 75,
            label: item.label,
            value: item.value,
            icon: item.icon != null
                ? Icon(item.icon, size: 22.0, color: AppColors.greyColor)
                : null,
        );
    }
}