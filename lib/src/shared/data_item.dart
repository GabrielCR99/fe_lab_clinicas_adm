import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

final class DataItem extends StatelessWidget {
  final String label;
  final String value;
  final EdgeInsetsGeometry? padding;

  const DataItem({
    required this.label,
    required this.value,
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = Row(
      children: [
        Flexible(
          child: Text(
            '$label: ',
            style: const TextStyle(
              color: blueColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              color: orangeColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );

    if (padding != null) {
      widget = Padding(padding: padding!, child: widget);
    }

    return widget;
  }
}
