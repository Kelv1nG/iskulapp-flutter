import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class CustomItemCard extends StatelessWidget {
  final void Function(BuildContext context)? routeFunc;
  final List<Widget> itemContents;

  const CustomItemCard({super.key, this.routeFunc, required this.itemContents});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double verticalPadding = screenHeight * 0.02;

    return InkWell(
      onTap: () {
        if (routeFunc != null) {
          routeFunc!(context);
        }
      },
      child: Card(
        margin: EdgeInsets.only(bottom: verticalPadding),
        elevation: 1,
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(verticalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: itemContents,
          ),
        ),
      ),
    );
  }
}

