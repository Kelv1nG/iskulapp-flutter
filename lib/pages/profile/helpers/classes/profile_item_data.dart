import 'package:flutter/material.dart';

class ProfileItemData {
    final String label;
    final String value;
    final IconData? icon;
    final double width;

    ProfileItemData(this.label, this.value, [this.icon, this.width = 175]);
}