import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class NextButton extends StatelessWidget {
  final Function onPressed;

  const NextButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        "Next",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
