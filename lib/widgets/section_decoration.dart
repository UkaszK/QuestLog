import 'package:flutter/material.dart';
import 'package:questlog/constants/themed_colors.dart';

class SectionDecoration extends BoxDecoration {
  SectionDecoration()
    : super(
        border: Border.all(color: ThemedColors.border, width: 1),
        borderRadius: BorderRadius.circular(2),
        color: ThemedColors.surface,
      );
}
