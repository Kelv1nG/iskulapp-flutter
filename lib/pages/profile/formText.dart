import 'package:flutter/material.dart';

class FormText extends StatelessWidget {
    final double width;
    final double height;
    final String label;
    final String value;
    final MainAxisAlignment mainAxisAlignment;
    final CrossAxisAlignment crossAxisAlignment;
    final Icon? icon; // Optional icon parameter

    const FormText({
        super.key,
        required this.width,
        required this.height,
        required this.label,
        required this.value,
        this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
        this.crossAxisAlignment = CrossAxisAlignment.center,
        this.icon, // Initialize icon as null by default
    });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.5),
                    ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(label),
                        Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                                mainAxisAlignment: mainAxisAlignment,
                                crossAxisAlignment: crossAxisAlignment,
                                children: [
                                    Expanded(
                                        child: Text(
                                            value,
                                            overflow: TextOverflow.ellipsis, // Truncate text if it overflows
                                            maxLines: 1, // Ensure only 1 line of text
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                            ),
                                        ),
                                    ),
                                    if (icon != null) // Conditional check for icon
                                    Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: icon!,
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
