import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemedSvgIcon extends StatelessWidget {
  final String assetPath;

  const ThemedSvgIcon(this.assetPath, {super.key});

  @override
  Widget build(BuildContext context) {
    final color = IconTheme.of(context).color ?? Colors.black;
    return SvgPicture.asset(
      assetPath,
      width: 20,
      height: 20,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
