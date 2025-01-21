import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/lists/custom_list_view.dart';
import 'package:school_erp/pages/profile/helpers/classes/profile_item_data.dart';
import 'package:school_erp/pages/profile/widgets/profile_details_card.dart';

class ProfileDetailsList extends StatelessWidget{
    final List<ProfileItemData> items;

    const ProfileDetailsList({super.key, required this.items});

    @override
    Widget build(BuildContext context) {
        return CustomListView<ProfileItemData>(
            listOfData: items,
            itemBuilder: (context, profileItem) => ProfileDetailsCard(item: profileItem));
    }
}